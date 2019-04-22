import numpy as np
import tensorflow as tf
from tensorflow.keras import layers

train = np.genfromtxt('sets/train_set.csv', delimiter=',').T
np.random.shuffle(train)
train_set_labels = train[:,0];
train_set_labels = np.array([train_set_labels, 1-train_set_labels]).T.astype(int)
train_set = train[:,1:];


test = np.genfromtxt('sets/test_set.csv', delimiter=',').T
test_set_labels = test[:,0];
test_set_labels = np.array([test_set_labels, 1-test_set_labels]).T.astype(int)
test_set = test[:,1:];


model = tf.keras.Sequential([
# Adds a densely-connected layer with 64 units to the model:
layers.Dense(64, activation='sigmoid', input_shape=(train_set.shape[1],)),
# Add another:
layers.Dense(128,activation='relu'),
# Add a softmax layer with 10 output units:
layers.Dense(2, activation='softmax')])

model.compile(optimizer=tf.train.AdamOptimizer(0.001),
              loss='binary_crossentropy',
              metrics=['accuracy'])

model.fit(train_set, train_set_labels, epochs=200, batch_size=20)

print('Now let\'s evaluate')
model.evaluate(test_set, test_set_labels, batch_size=1)

s = np.sum(test_set_labels, axis=0)

pred = model.predict(test_set, batch_size=1)

test_chris = np.genfromtxt('sets/chris_test.csv', delimiter=',').T
pred_chris = model.predict(test_chris, batch_size=1)
print('Probability of acceptance:\t'+str(np.mean(pred_chris, axis=0)[0]))
print('Probability of rejection:\t'+str(np.mean(pred_chris, axis=0)[1]))

test_cillian = np.genfromtxt('sets/cillian_test.csv', delimiter=',').T
pred_cillian = model.predict(test_cillian, batch_size=1)
