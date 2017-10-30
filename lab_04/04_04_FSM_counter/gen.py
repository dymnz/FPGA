for i in range(0, 11):
	print('		S{}:'.format(i))
	print('			if (~W[1] & ~W[0]) begin'.format(i))
	print('				next_state = S{};'.format(i))	
	print('			end else if (~W[1] & W[0]) begin')
	print('				next_state = S{};'.format(i+1))
	print('			end else if (W[1] & ~W[0]) begin')
	print('				next_state = S{};'.format(i+2))
	print('			end else if (W[1] & W[0]) begin')
	print('				next_state = S{};'.format(i-1))
	print('			end')




