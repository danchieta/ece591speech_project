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

model.fit(train_set, train_set_labels, epochs=50, batch_size=10)

print('Now let\'s evaluate')
model.evaluate(test_set, test_set_labels, batch_size=1)

s = np.sum(test_set_labels, axis=0)

pred = model.predict(test_set, batch_size=1)

print('\n\nEnrolled speaker')
print('================')
test_chris = np.genfromtxt('sets/chris_test.csv', delimiter=',').T
pred_chris = model.predict(test_chris, batch_size=1)
mean_prob_chris1 = np.mean(pred_chris, axis=0)
score = np.log10(mean_prob_chris1[0]/mean_prob_chris1[1])
print('\nChris Martin\'s speech:')
print('Probability of acceptance:\t'+str(mean_prob_chris1[0]))
print('Probability of rejection:\t'+str(mean_prob_chris1[1]))
print('Score: \t\t\t\t'+ str(score))

test_chris2 = np.genfromtxt('sets/chris_test2.csv', delimiter=',').T
pred_chris2 = model.predict(test_chris2, batch_size=1)
mean_prob_chris2 = np.mean(pred_chris2, axis=0)
score = np.log10(mean_prob_chris2[0]/mean_prob_chris2[1])
print('\n\nChris Martin\'s speech 2:')
print('Probability of acceptance:\t'+str(mean_prob_chris2[0]))
print('Probability of rejection:\t'+str(mean_prob_chris2[1]))
print('Score: \t\t\t\t'+ str(score))

print('\n\nUnenrolled speaker')
print('=================')
test_cillian = np.genfromtxt('sets/cillian_test.csv', delimiter=',').T
pred_cillian = model.predict(test_cillian, batch_size=1)
mean_prob_cillian = np.mean(pred_cillian, axis=0)
score = np.log10(mean_prob_cillian[0]/mean_prob_cillian[1])
print('\nCillian Murphy\'s speech:')
print('Probability of acceptance:\t'+str(mean_prob_cillian[0]))
print('Probability of rejection:\t'+str(mean_prob_cillian[1]))
print('Score: \t\t\t\t'+ str(score))

test_tilda = np.genfromtxt('sets/tilda_test.csv', delimiter=',').T
pred_tilda = model.predict(test_tilda, batch_size=1)
print('\n\nTilda Swinton\'s speech:')
mean_prob_tilda = np.mean(pred_tilda, axis=0)
print('Probability of acceptance:\t'+str(mean_prob_tilda[0]))
print('Probability of rejection:\t'+str(mean_prob_tilda[1]))
score = np.log10(mean_prob_tilda[0]/mean_prob_tilda[1])
print('Score: \t\t\t\t'+ str(score))

test_jesse = np.genfromtxt('sets/jesse_test.csv', delimiter=',').T
pred_jesse= model.predict(test_jesse, batch_size=1)
print('\n\nJesse Eisemberg\'s speech:')
mean_prob_jesse = np.mean(pred_jesse, axis=0)
print('Probability of acceptance:\t'+str(mean_prob_jesse[0]))
print('Probability of rejection:\t'+str(mean_prob_jesse[1]))
score = np.log10(mean_prob_jesse[0]/mean_prob_jesse[1])
print('Score: \t\t\t\t'+ str(score))
