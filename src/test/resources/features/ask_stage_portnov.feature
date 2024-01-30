
@ask_stage_portnov
Feature: ask_stage_portnov

  @RegistrationStep1
  Scenario Outline: Registration positive (Step1 - Registration data)
    Given I open url "http://ask-stage.portnov.com/"
    Then I wait for element with xpath "//*[text()='Register Now']" to be present
    Then I click on element with xpath "//*[text()='Register Now']"
    Then I wait for element with xpath "//*[text()='First Name']/../.." to be present
    Then I type "<FirstName>" into element with xpath "//*[text()='First Name']/../../input"
    Then I type "<LastName>" into element with xpath "//*[text()='Last Name']/../../input"
    Then I type "<Email>" into element with xpath "//*[text()='Email']/../../input"
    Then I type "<GroupCode>" into element with xpath "//*[text()='Group Code']/../../input"
    Then I type "<Password>" into element with xpath "//*[text()='Password']/../../input"
    Then I type "<ConfirmPassword>" into element with xpath "//*[text()='Confirm Password']/../../input"
    Then I click on element with xpath "//*[text()='Register Me']/.."
    Then I wait for 2 sec
    Then I wait for element with xpath "//h4[text()='You have been Registered.']" to be present
    Then element with xpath "//h4[text()='You have been Registered.']" should be present
    Then I wait for 5 sec
    Examples:
##    |FirstName|LastName            |Email                    |GroupCode|Password|ConfirmPassword|
##    |Anatoliy |KolesnikTeacherOne|anatoliy.nk84+1@gmail.com|052623   |a052623 |a052623         |
##    |Anatoliy |Kolesnik (Teacher#2)|anatoliy.nk84+2@gmail.com|052623   |a052623  |a052623         |
##    |Anatoliy |Kolesnik (Student#1)|anatoliy.nk84+3@gmail.com|052623   |a052623 |a052623         |
##    |Anatoliy |Kolesnik (Student#2)|anatoliy.nk84+4@gmail.com|052623   |a052623  |a052623         |
      |FirstName|LastName               |Email                       |GroupCode|Password |ConfirmPassword |AdminEmail       |AdminPassword|
      |Anatoliy |KolesnikAutoTestStudent|anatoliyStudent@fakeMail.com|052623   |a052623  |a052623         |teacher@gmail.com|12345Abc     |
      |Anatoliy |KolesnikAutoTestTeacher|anatoliyTeacher@fakeMail.com|052623   |a052623  |a052623         |teacher@gmail.com|12345Abc     |

  @RegistrationStep2
  Scenario Outline: Registration positive (Step2 - Activation)
    Given I activate user with email "<Email>"
#    Then element with xpath "//*[contains(text(), 'success')]" should be present
    Then I wait for 5 sec
    Examples:
      |FirstName|LastName               |Email                       |GroupCode|Password |ConfirmPassword |AdminEmail       |AdminPassword|
      |Anatoliy |KolesnikAutoTestStudent|anatoliyStudent@fakeMail.com|052623   |a052623  |a052623         |teacher@gmail.com|12345Abc     |
      |Anatoliy |KolesnikAutoTestTeacher|anatoliyTeacher@fakeMail.com|052623   |a052623  |a052623         |teacher@gmail.com|12345Abc     |



  @RoleToTeacher
  Scenario Outline: Change the role to Teacher positive
    Given I open url "http://ask-stage.portnov.com/"
    Then I wait for element with xpath "//*[text()='Sign In']/.." to be present
    Then I type "<AdminEmail>" into element with xpath "//*[text()='Email *']/../../input"
    Then I type "<AdminPassword>" into element with xpath "//*[text()='Password *']/../../input"
    Then I click on element with xpath "//*[text()='Sign In']/.."
    Then I wait for element with xpath "//*[text()='Settings']/.." to be present
    Then I wait for element with xpath "//*[contains(text(), 'Management')]/.." to be present
#    Then I click on element User s Management
    Then I click on element with xpath "//*[contains(text(), 'User') and contains(text(), 's Management')]/../../.."

    Then I wait for element with xpath "//*[contains(text(), '<FirstName> <LastName>')]/../../.." to be present
    Then I click on element with xpath "//*[contains(text(), '<FirstName> <LastName>')]/../../.."

    Then I wait for element with xpath "//button/span/*[contains(text(),'settings')]/../.." to be present
    Then I wait for 6 sec
    Then I click on element with xpath "//button/span/*[contains(text(),'settings')]/../.."

    Then I wait for element with xpath "//*/button/*[contains(text(),'group')]" to be present
    Then I wait for element with xpath "//*/button/*[contains(text(),'edit')]" to be present
    Then I wait for element with xpath "//*/button/*[contains(text(),'school')]" to be present
    Then I wait for element with xpath "//*/button/*[contains(text(),'delete')]" to be present
    Then I wait for element with xpath "//*/button/*[contains(text(),'school')]/.." to be present
    Then I click on element with xpath "//*/button/*[contains(text(),'school')]/.."

    Then I wait for element with xpath "//*[text() = 'Change Role']/.." to be present
    Then I click on element with xpath "//*[text() = 'Change Role']/.."
#    Then I wait for 3 sec
    Then I wait for element with xpath "//td[text()='TEACHER']" to be present
    Then I wait for 5 sec
    
    Examples:
      |FirstName|LastName               |Email                       |GroupCode|Password |ConfirmPassword |AdminEmail       |AdminPassword|
      |Anatoliy |KolesnikAutoTestTeacher|anatoliyTeacher@fakeMail.com|052623   |a052623  |a052623         |teacher@gmail.com|12345Abc     |



  @CreateQuiz
  Scenario Outline: Create Quiz:
    Given I open url "http://ask-stage.portnov.com/"
    Then I wait for element with xpath "//*[text()='Sign In']/.." to be present
    Then I type "<Email>" into element with xpath "//*[text()='Email *']/../../input"
    Then I type "<Password>" into element with xpath "//*[text()='Password *']/../../input"
    Then I click on element with xpath "//*[text()='Sign In']/.."
    Then I wait for element with xpath "//*[text()='Settings']/.." to be present
    Then I wait for element with xpath "//*[contains(text(), 'Management')]/.." to be present
    Then I wait for element with xpath "//*[text()='Quizzes']" to be present
    Then I click on element with xpath "//*[text()='Quizzes']"
    Then I wait for element with xpath "//*[text()='Create New Quiz']/.." to be present
    Then I click on element with xpath "//*[text()='Create New Quiz']/.."
    Then I wait for element with xpath "//*[contains(text(), 'Title Of The Quiz')]" to be present
    Then I wait for element with xpath "//*[contains(text(), 'Title Of The Quiz')]/../../input" to be present
    Then I type "Anatoliy Test Automation Quiz" into element with xpath "//*[contains(text(), 'Title Of The Quiz')]/../../input"

    Then I add Quiz questions from XLSX "src/1-1.xlsx"

    Then I click on element with xpath "//*[contains(text(), 'Save')]/.."
    Then I wait for element with xpath "//*[contains(text(), 'Anatoliy Test Automation Quiz')]/../.." to be present
    Then I click on element with xpath "//*[contains(text(), 'Anatoliy Test Automation Quiz')]/../.."
    Then I wait for element with xpath "//*[contains(text(), 'Anatoliy Test Automation Quiz')]/../../../div/div/div/div/button[1]" to be present
    Then I wait for 3 sec
    Then I scroll to the element with xpath "//*[contains(text(), 'Anatoliy Test Automation Quiz')]/../../../div/div/div/div/button[1]" with offset 5
    Then I wait for 3 sec
    Then I click on element with xpath "//*[contains(text(), 'Anatoliy Test Automation Quiz')]/../../../div/div/div/div/button[1]"

    Then I wait for 1 sec
    Then I take screenshot
#    Then I check Quiz questions from XLSX "src/51.xlsx"

    Then I wait for 5 sec
    Examples:
      |FirstName|LastName               |Email                       |GroupCode|Password |ConfirmPassword |AdminEmail       |AdminPassword|
      |Anatoliy |KolesnikAutoTestTeacher|anatoliyTeacher@fakeMail.com|052623   |a052623  |a052623         |teacher@gmail.com|12345Abc     |



  @DeleteQuiz
  Scenario Outline: Delete Quiz:
    Given I open url "http://ask-stage.portnov.com/"
    Then I wait for element with xpath "//*[text()='Sign In']/.." to be present
    Then I type "<Email>" into element with xpath "//*[text()='Email *']/../../input"
    Then I type "<Password>" into element with xpath "//*[text()='Password *']/../../input"
    Then I click on element with xpath "//*[text()='Sign In']/.."
    Then I wait for element with xpath "//*[text()='Settings']/.." to be present
    Then I wait for element with xpath "//*[contains(text(), 'Management')]/.." to be present
    Then I wait for element with xpath "//*[text()='Quizzes']" to be present
    Then I click on element with xpath "//*[text()='Quizzes']"
    Then I wait for element with xpath "//*[text()='Create New Quiz']/.." to be present

    Then I wait for element with xpath "//*[contains(text(), 'Anatoliy Test Automation Quiz')]/../.." to be present
    Then I click on element with xpath "//*[contains(text(), 'Anatoliy Test Automation Quiz')]/../.."

    Then I wait for element with xpath "//*[contains(text(), 'Anatoliy Test Automation Quiz')]/../../../div/div/div/div/button[2]" to be present
    Then I wait for 3 sec
    Then I scroll to the element with xpath "//*[contains(text(), 'Anatoliy Test Automation Quiz')]/../../../div/div/div/div/button[2]" with offset 5
    Then I wait for 3 sec
    Then I click on element with xpath "//*[contains(text(), 'Anatoliy Test Automation Quiz')]/../../../div/div/div/div/button[2]"

    Then I wait for element with xpath "//button[@aria-label='Close dialog']/span[text()='Delete']" to be present
    Then I click on element with xpath "//button[@aria-label='Close dialog']/span[text()='Delete']"

    Then I wait for 5 sec
    Examples:
      |FirstName|LastName               |Email                       |GroupCode|Password |ConfirmPassword |AdminEmail       |AdminPassword|
      |Anatoliy |KolesnikAutoTestTeacher|anatoliyTeacher@fakeMail.com|052623   |a052623  |a052623         |teacher@gmail.com|12345Abc     |



  @RoleToStudent
  Scenario Outline: Change the role to Student positive
    Given I open url "http://ask-stage.portnov.com/"
    Then I wait for element with xpath "//*[text()='Sign In']/.." to be present
    Then I type "<AdminEmail>" into element with xpath "//*[text()='Email *']/../../input"
    Then I type "<AdminPassword>" into element with xpath "//*[text()='Password *']/../../input"
    Then I click on element with xpath "//*[text()='Sign In']/.."
    Then I wait for element with xpath "//*[text()='Settings']/.." to be present
    Then I wait for element with xpath "//*[contains(text(), 'Management')]/.." to be present
#    Then I click on element User s Management
    Then I click on element with xpath "//*[contains(text(), 'User') and contains(text(), 's Management')]/../../.."

  Then I wait for element with xpath "//*[text()='Teachers']" to be present
  Then I wait for 3 sec
  Then I click on element with xpath "//*[text()='Teachers']"

    Then I wait for element with xpath "//*[contains(text(), '<FirstName> <LastName>')]/../../.." to be present
    Then I click on element with xpath "//*[contains(text(), '<FirstName> <LastName>')]/../../.."

    Then I wait for element with xpath "//button/span/*[contains(text(),'settings')]/../.." to be present
    Then I wait for 6 sec
    Then I click on element with xpath "//button/span/*[contains(text(),'settings')]/../.."

#  Then I wait for element with xpath "//*/button/*[contains(text(),'group')]" to be present
    Then I wait for element with xpath "//*/button/*[contains(text(),'edit')]" to be present
    Then I wait for element with xpath "//*/button/*[contains(text(),'school')]" to be present
    Then I wait for element with xpath "//*/button/*[contains(text(),'delete')]" to be present
    Then I wait for element with xpath "//*/button/*[contains(text(),'school')]/.." to be present
    Then I wait for 2 sec
    Then I click on element with xpath "//*/button/*[contains(text(),'school')]/.."

    Then I wait for element with xpath "//*[text() = 'Change Role']/.." to be present
    Then I click on element with xpath "//*[text() = 'Change Role']/.."
#    Then I wait for 3 sec
    Then I wait for element with xpath "//td[text()='STUDENT']" to be present
    Then I wait for 5 sec
    Examples:
      |FirstName|LastName               |Email                       |GroupCode|Password |ConfirmPassword |AdminEmail       |AdminPassword|
      |Anatoliy |KolesnikAutoTestTeacher|anatoliyTeacher@fakeMail.com|052623   |a052623  |a052623         |teacher@gmail.com|12345Abc     |



  @DeleteUsers
  Scenario Outline: Delete the user positive
    Given I open url "http://ask-stage.portnov.com/"
    Then I wait for element with xpath "//*[text()='Sign In']/.." to be present
    Then I type "<AdminEmail>" into element with xpath "//*[text()='Email *']/../../input"
    Then I type "<AdminPassword>" into element with xpath "//*[text()='Password *']/../../input"
    Then I click on element with xpath "//*[text()='Sign In']/.."
    Then I wait for element with xpath "//*[text()='Settings']/.." to be present
    Then I wait for element with xpath "//*[contains(text(), 'Management')]/.." to be present
#    Then I click on element User s Management
    Then I wait for 2 sec
    Then I click on element with xpath "//*[contains(text(), 'User') and contains(text(), 's Management')]/../../.."

    Then I wait for element with xpath "//*[contains(text(), '<FirstName> <LastName>')]/../../.." to be present
    Then I wait for 1 sec
    Then I click on element with xpath "//*[contains(text(), '<FirstName> <LastName>')]/../../.."

    Then I wait for element with xpath "//button/span/*[contains(text(),'settings')]/../.." to be present
    Then I wait for 6 sec
    Then I click on element with xpath "//button/span/*[contains(text(),'settings')]/../.."

    Then I wait for element with xpath "//*/button/*[contains(text(),'group')]" to be present
    Then I wait for element with xpath "//*/button/*[contains(text(),'edit')]" to be present
    Then I wait for element with xpath "//*/button/*[contains(text(),'school')]" to be present
    Then I wait for element with xpath "//*/button/*[contains(text(),'delete')]" to be present
    Then I wait for element with xpath "//*[text()='delete']/.." to be present
    Then I wait for 1 sec
    Then I click on element with xpath "//*[text()='delete']/.."

    Then I wait for element with xpath "//*[text()='Delete']/.." to be present
    Then I click on element with xpath "//*[text()='Delete']/.."

    Then I wait for 2 sec
    Then element with xpath "//*[contains(text(), '<FirstName> <LastName>')]/../../.." should not be present
    Then I wait for 5 sec
    Examples:
      |FirstName|LastName               |Email                       |GroupCode|Password |ConfirmPassword |AdminEmail       |AdminPassword|
      |Anatoliy |KolesnikAutoTestStudent|anatoliyStudent@fakeMail.com|052623   |a052623  |a052623         |teacher@gmail.com|12345Abc     |
      |Anatoliy |KolesnikAutoTestTeacher|anatoliyTeacher@fakeMail.com|052623   |a052623  |a052623         |teacher@gmail.com|12345Abc     |


#    |Anatoliy |Kolesnik (TestGroup#1pos)|anatoliy.nk84+11@gmail.com|az09!   |a052623 |a052623         |
#    |Anatoliy |Kolesnik (TestGroup#2pos)|anatoliy.nk84+12@gmail.com|aAaZzZ   |a052623  |a052623         |
#    |Anatoliy |Kolesnik (TestGroup#3pos)|anatoliy.nk84+13@gmail.com|12345   |a052623 |a052623         |
#    |Anatoliy |Kolesnik (TestGroup#4pos)|anatoliy.nk84+14@gmail.com|!@#$%   |a052623  |a052623         |
#    |Anatoliy |Kolesnik (TestGroup#4pos)|anatoliy.nk84+14@gmail.com|A   |a052623  |a052623         |
#    |Anatoliy |Kolesnik (TestGroup#4pos)|anatoliy.nk84+14@gmail.com|!   |a052623  |a052623         |

#    |Anatoliy |Kolesnik (TestGroup#5pos)|anatoliy.nk84+15@gmail.com|az09!az09!   |a052623 |a052623         |
#    |Anatoliy |Kolesnik (TestGroup#6pos)|anatoliy.nk84+16@gmail.com|abcdefghij   |a052623  |a052623         |
#    |Anatoliy |Kolesnik (TestGroup#7pos)|anatoliy.nk84+17@gmail.com|0123456789   |a052623 |a052623         |
#    |Anatoliy |Kolesnik (TestGroup#8pos)|anatoliy.nk84+18@gmail.com|!@#$%^&*()   |a052623  |a052623         |

#    |Anatoliy |Kolesnik (TestGroup#4pos)|anatoliy.nk84+14@gmail.com|   |a052623  |a052623         |





#  Scenario Outline: Change account type to Teacher
#    Given I open url "http://ask-stage.portnov.com/"
#    Then I wait for element with xpath "//*[text()='Sign In']/.." to be present
#    Then I type "<Email>" into element with xpath "//*[text()='Email *']/../../input"
#    Then I type "<Password>" into element with xpath "//*[text()='Password *']/../../input"
#    Then I click on element with xpath "//*[text()='Sign In']/.."
#    Then I wait for element with xpath "//*[text()='Settings']/.." to be present
#    Then I wait for element with xpath "//*[contains(text(), 'Management')]/.." to be present
#    Then I click on element User s Management
#    Then I wait for element with xpath "//*[contains(text(), '<LastName>')]/../../../.." to be present
#    Then I click on element with xpath "//*[contains(text(), '<LastName>')]/../../../.."
#
#    Then I wait for element with xpath "//*/span/mat-icon[contains(text(), 'settings')]/../.." to be present
#    Then I wait for 2 sec
#    Then I click on element with xpath "//*/span/mat-icon[contains(text(), 'settings')]/../.."
#
#    Then I wait for element with xpath "//*/button/*[contains(text(),'group')]" to be present
#    Then I wait for element with xpath "//*/button/*[contains(text(),'edit')]" to be present
#    Then I wait for element with xpath "//*/button/*[contains(text(),'school')]" to be present
#    Then I wait for element with xpath "//*/button/*[contains(text(),'delete')]" to be present
#    Then I wait for element with xpath "//*/button/*[contains(text(),'school')]/.." to be present
#
#    Then I click on element with xpath "//*/button/*[contains(text(),'school')]/.."
#
#    Then I wait for element with xpath "//*[text() = 'Change Role']/.." to be present
#    Then I click on element with xpath "//*[text() = 'Change Role']/.."
#    Then I wait for 3 sec
##    Then I wait for element with xpath "td[text()='TEACHER']" to be present
#
#
#    Examples:
#    |FirstName|LastName            |Email                    |GroupCode|Password|ConfirmPassword|
#    |Anatoliy |Kolesnik (Teacher#1)|teacher@gmail.com        |052623   |12345Abc|052623         |
#    |Anatoliy |Kolesnik (Teacher#2)|teacher@gmail.com        |052623   |12345Abc|052623         |








#  Scenario Outline: Login negative
#    Given I open url "http://ask-stage.portnov.com/"
#    Then I wait for element with xpath "//*[text()='Sign In']/.." to be present
#    Then I type "<Email>" into element with xpath "//*[text()='Email *']/../../input"
#    Then I type "<Password>" into element with xpath "//*[text()='Password *']/../../input"
#    Then I click on element with xpath "//*[text()='Sign In']/.."
#
#    Then I wait for 1000 sec
#    Examples:
#    |FirstName|LastName            |Email                    |GroupCode|Password|ConfirmPassword|
#    |Anatoliy |Kolesnik (Teacher#1)|anatoliy.nk84+2@gmail.com|052623   |a052621  |052623         |



#  Scenario Outline: Create steps in jira:
#    Given I open url "https://jira.portnov.com/browse/ASK111623-287"
#    Then I wait for element with xpath "//*[text()='Sign In']/.." to be present
#    Then I type "<Email>" into element with xpath "//*[text()='Email *']/../../input"
#    Then I type "<Password>" into element with xpath "//*[text()='Password *']/../../input"
#    Then I click on element with xpath "//*[text()='Sign In']/.."
#    Then I wait for element with xpath "//*[text()='Settings']/.." to be present
#    Then I wait for element with xpath "//*[contains(text(), 'Management')]/.." to be present
#    Then I wait for element with xpath "//*[text()='Quizzes']" to be present
#    Then I click on element with xpath "//*[text()='Quizzes']"
#    Then I wait for element with xpath "//*[text()='Create New Quiz']/.." to be present
#    Then I click on element with xpath "//*[text()='Create New Quiz']/.."
#    Then I wait for element with xpath "//*[contains(text(), 'Title Of The Quiz')]" to be present
#    Then I wait for element with xpath "//*[contains(text(), 'Title Of The Quiz')]/../../input" to be present
#    Then I type "Anatoliy +50 test2" into element with xpath "//*[contains(text(), 'Title Of The Quiz')]/../../input"
#    Then I add Quiz questions from XLSX
#    Then I wait for 10 sec
#    Examples:
#    |FirstName|LastName            |Email                    |GroupCode|Password|ConfirmPassword|
#    |Anatoliy |Kolesnik (Teacher#1)|anatoliy.nk84+1@gmail.com|052623   |a052623  |052623         |
