FasdUAS 1.101.10   ��   ��    k             l      ��  ��   SM
"Replay Last Bit" for iTunes
written by Doug Adams
dougadams@mac.com

v2.0 september 9 2004
-- runs as a stay-open script
-- alternates between pausing and rewinding

v1.0 february 27 2004
initial release

Get more free AppleScripts and info on writing your own
at Doug's AppleScripts for iTunes
http://www.malcolmadams.com/itunes/
     � 	 	� 
 " R e p l a y   L a s t   B i t "   f o r   i T u n e s 
 w r i t t e n   b y   D o u g   A d a m s 
 d o u g a d a m s @ m a c . c o m 
 
 v 2 . 0   s e p t e m b e r   9   2 0 0 4 
 - -   r u n s   a s   a   s t a y - o p e n   s c r i p t 
 - -   a l t e r n a t e s   b e t w e e n   p a u s i n g   a n d   r e w i n d i n g 
 
 v 1 . 0   f e b r u a r y   2 7   2 0 0 4 
 i n i t i a l   r e l e a s e 
 
 G e t   m o r e   f r e e   A p p l e S c r i p t s   a n d   i n f o   o n   w r i t i n g   y o u r   o w n 
 a t   D o u g ' s   A p p l e S c r i p t s   f o r   i T u n e s 
 h t t p : / / w w w . m a l c o l m a d a m s . c o m / i t u n e s / 
   
  
 l     ��������  ��  ��        l     ��  ��    9 3 change the number of seconds to rewind if you like     �   f   c h a n g e   t h e   n u m b e r   o f   s e c o n d s   t o   r e w i n d   i f   y o u   l i k e      j     �� �� 0 secondstoskip secondsToSkip  m     ����       l     ��������  ��  ��        j    �� �� $0 itunes_is_paused iTunes_is_paused  m    ��
�� boovfals      l     ��������  ��  ��        i    	    I     ������
�� .aevtoappnull  �   � ****��  ��    k           !   I     �������� 0 rewinditunes rewindiTunes��  ��   !  "�� " r     # $ # m    ��
�� boovfals $ o      ���� $0 itunes_is_paused iTunes_is_paused��     % & % l     ��������  ��  ��   &  ' ( ' l     �� ) *��   ) ; 5 every other call to reopen performs one of two tasks    * � + + j   e v e r y   o t h e r   c a l l   t o   r e o p e n   p e r f o r m s   o n e   o f   t w o   t a s k s (  , - , i   
  . / . I     ������
�� .aevtrappnull��� ��� null��  ��   / k     , 0 0  1 2 1 Z     * 3 4�� 5 3 o     ���� $0 itunes_is_paused iTunes_is_paused 4 k     6 6  7 8 7 I    �������� 0 rewinditunes rewindiTunes��  ��   8  9�� 9 r     : ; : m    ��
�� boovfals ; o      ���� $0 itunes_is_paused iTunes_is_paused��  ��   5 k    * < <  = > = O   " ? @ ? I   !������
�� .hookPausnull        null��  ��   @ m     A A�                                                                                  hook  alis    4  Kirk                       ���H+     �
iTunes.app                                                        �ƀ�*        ����  	                Applications    ��P�      ƁM�       �  Kirk:Applications:iTunes.app   
 i T u n e s . a p p  
  K i r k  Applications/iTunes.app   / ��   >  B�� B r   # * C D C m   # $��
�� boovtrue D o      ���� $0 itunes_is_paused iTunes_is_paused��   2  E�� E l  + +�� F G��   F 6 0 tell application "Some Application" to activate    G � H H `   t e l l   a p p l i c a t i o n   " S o m e   A p p l i c a t i o n "   t o   a c t i v a t e��   -  I J I l     ��������  ��  ��   J  K L K l     �� M N��   M * $ handler to rewind the current track    N � O O H   h a n d l e r   t o   r e w i n d   t h e   c u r r e n t   t r a c k L  P Q P i    R S R I      �������� 0 rewinditunes rewindiTunes��  ��   S O     < T U T Z    ; V W���� V >   	 X Y X 1    ��
�� 
pPlS Y m    ��
�� ePlSkPSS W k    7 Z Z  [ \ [ r     ] ^ ] 1    ��
�� 
pPos ^ o      ���� 0 pos   \  _�� _ Z    7 ` a���� ` l    b���� b A    c d c o    ���� 0 pos   d l    e���� e \     f g f l    h���� h n     i j i 1    ��
�� 
pStp j 1    ��
�� 
pTrk��  ��   g o    ���� 0 secondstoskip secondsToSkip��  ��  ��  ��   a k   " 3 k k  l m l r   " - n o n [   " ) p q p o   " #���� 0 pos   q o   # (���� 0 secondstoskip secondsToSkip o 1   ) ,��
�� 
pPos m  r�� r I  . 3������
�� .hookPlaynull    ��� obj ��  ��  ��  ��  ��  ��  ��  ��   U m      s s�                                                                                  hook  alis    4  Kirk                       ���H+     �
iTunes.app                                                        �ƀ�*        ����  	                Applications    ��P�      ƁM�       �  Kirk:Applications:iTunes.app   
 i T u n e s . a p p  
  K i r k  Applications/iTunes.app   / ��   Q  t u t l     ��������  ��  ��   u  v�� v l     ��������  ��  ��  ��       �� w���� x y z��   w ������������ 0 secondstoskip secondsToSkip�� $0 itunes_is_paused iTunes_is_paused
�� .aevtoappnull  �   � ****
�� .aevtrappnull��� ��� null�� 0 rewinditunes rewindiTunes�� 
�� boovfals x �� ���� { |��
�� .aevtoappnull  �   � ****��  ��   {   | ���� 0 rewinditunes rewindiTunes�� *j+  OfEc   y �� /���� } ~��
�� .aevtrappnull��� ��� null��  ��   }   ~ �� A���� 0 rewinditunes rewindiTunes
�� .hookPausnull        null�� -b   *j+  OfEc  Y � *j UOeEc  OP z �� S����  ����� 0 rewinditunes rewindiTunes��  ��    ���� 0 pos   �  s������������
�� 
pPlS
�� ePlSkPSS
�� 
pPos
�� 
pTrk
�� 
pStp
�� .hookPlaynull    ��� obj �� =� 9*�,� 0*�,E�O�*�,�,b    �b   *�,FO*j Y hY hUascr  ��ޭ