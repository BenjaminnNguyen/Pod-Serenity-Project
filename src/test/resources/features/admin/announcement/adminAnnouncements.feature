@feature=AdminAnnouncement
Feature: Admin Announcement

  @AD_ANNOUNCEMENT_1
  Scenario: Create an Announcement - validate
    Given BAO_ADMIN8 open web admin
    When BAO_ADMIN8 login to web with role Admin
    And Admin navigate to "Announcements" on sidebar
    And Admin go to create announcement
    And Click on button "Create"
    And BAO_ADMIN8 check error message is showing of fields on dialog
      | field       | message                                               |
      | Title       | Please input title for this announcement              |
      | Body        | Please input body for this announcement               |
      | Announce to | Please select a announcement to for this announcement |
    And BAO_ADMIN8 check error message not showing of fields on dialog
      | field                 | message |
      | Link                  | Please  |
      | Link title            | Please  |
      | Start delivering date | Please  |
      | Stop delivering date  | Please  |

  @AD_ANNOUNCEMENT_2
  Scenario: Create an Announcement 2
    Given BAO_ADMIN8 open web admin
    When BAO_ADMIN8 login to web with role Admin
    And Admin navigate to "Announcements" on sidebar
    And Admin go to create announcement
    And Admin create announcement with info
      | title     | body              | link        | linkTitle   | announceTo | startDate | stopDate |
      | Auto test | Auto Announcement | podfoods.co | podfoods.co | All users  | Minus1    | Plus1    |
    And Admin create announcement with region
      | region              |
      | Chicagoland Express |
      | Pod Direct West     |
    And Admin confirm create announcement
    And Admin check announcement list
      | id      | title | announceTo | startDate | stopDate |
      | [blank] | Auto  | All users  | Minus1    | Plus1    |
    And Admin go to create announcement
    And Admin create announcement with info
      | title     | body              | link | linkTitle | announceTo | startDate | stopDate |
      | Auto test | Auto Announcement | a    | [blank]   | LP         | [blank]   | [blank]  |
    And Admin confirm create announcement
    And BAO_ADMIN8 check alert message
      | Link is invalid |
    And Admin create announcement with info
      | title     | body              | link         | linkTitle | announceTo | startDate | stopDate |
      | Auto test | Auto Announcement | podfoods.co1 | [blank]   | LP         | [blank]   | [blank]  |
    And Admin confirm create announcement
    And BAO_ADMIN8 check alert message
      | Link is invalid |
    And Admin create announcement with info
      | title     | body              | link    | linkTitle | announceTo | startDate | stopDate |
      | Auto test | Auto Announcement | [blank] | a         | LP         | [blank]   | [blank]  |
    And Admin confirm create announcement
    And BAO_ADMIN8 check alert message
      | Link is invalid |
    And Admin create announcement with info
      | title     | body              | link    | linkTitle    | announceTo | startDate | stopDate |
      | Auto test | Auto Announcement | [blank] | podfoods.co1 | LP         | [blank]   | [blank]  |
    And Admin confirm create announcement
    And BAO_ADMIN8 check alert message
      | Link is invalid |
    And Admin close dialog form
    And Admin go to create announcement

    And Admin create announcement with info
      | title     | body              | link    | linkTitle | announceTo | startDate | stopDate    |
      | Auto test | Auto Announcement | [blank] | [blank]   | LP         | Plus1     | currentDate |
    And Admin confirm create announcement
    And Admin check announcement list
      | id      | title     | announceTo | startDate | stopDate |
      | [blank] | Auto test | LP         | Plus1     | [blank]  |
    And Admin go to create announcement
    And Admin create announcement with info
      | title     | body              | link    | linkTitle | announceTo | startDate | stopDate |
      | Auto test | Auto Announcement | [blank] | [blank]   | LP         | [blank]   | Plus1    |
    And Admin confirm create announcement
    And Admin check announcement list
      | id      | title     | announceTo | startDate | stopDate |
      | [blank] | Auto test | LP         | [blank]   | Plus1    |

  @AD_ANNOUNCEMENT_3 @AD_ANNOUNCEMENT_15
  Scenario: Check Announcement list
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao8@podfoods.co | 12345678a |
    And Admin search announcements api
      | q[title]  | q[body] | q[recipient_type] | q[start_delivering_date] |
      | Auto test | [blank] | [blank]           | [blank]                  |
    And Admin delete announcements by api
    Then Admin set region of announcements api
      | 26 |
    And Admin create announcements by api
      | name      | title       | body                   | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test | Auto test 1 | Auto test announcement | buyer          | currentDate           | Plus1                | podfoods.co | podfoods.co |
    And Admin create announcements by api
      | name      | title       | body                   | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test | Auto test 2 | Auto test announcement | vendor         | currentDate           | Plus1                | podfoods.co | podfoods.co |
    Given BAO_ADMIN8 open web admin
    When BAO_ADMIN8 login to web with role Admin
    And Admin navigate to "Announcements" on sidebar
    And Admin check announcement list
      | id            | title       | announceTo | startDate   | stopDate |
      | create by api | Auto test 2 | Vendor     | currentDate | Plus1    |
      | [blank]       | Auto test 1 | Buyer      | currentDate | Plus1    |
    And Admin search announcement
      | title     | body    | announcementTo | from    |
      | Auto test | [blank] | [blank]        | [blank] |
    And Admin check announcement list
      | id      | title       | announceTo | startDate   | stopDate |
      | [blank] | Auto test 2 | Vendor     | currentDate | Plus1    |
      | [blank] | Auto test 1 | Buyer      | currentDate | Plus1    |

    And Admin search announcement
      | title   | body                   | announcementTo | from    |
      | [blank] | Auto test announcement | [blank]        | [blank] |
    And Admin check announcement list
      | id      | title       | announceTo | startDate   | stopDate |
      | [blank] | Auto test 2 | Vendor     | currentDate | Plus1    |
      | [blank] | Auto test 1 | Buyer      | currentDate | Plus1    |
    And Admin search announcement
      | title   | body                   | announcementTo | from    |
      | [blank] | Auto test announcement | [blank]        | [blank] |
    And Admin check announcement list
      | id      | title       | announceTo | startDate   | stopDate |
      | [blank] | Auto test 2 | Vendor     | currentDate | Plus1    |
      | [blank] | Auto test 1 | Buyer      | currentDate | Plus1    |
    And Admin search announcement
      | title   | body    | announcementTo | from    |
      | [blank] | [blank] | All users      | [blank] |
    And Admin search announcement
      | title   | body    | announcementTo | from    |
      | [blank] | [blank] | LP             | [blank] |
    And Admin search announcement
      | title   | body    | announcementTo | from    |
      | [blank] | [blank] | Buyer          | [blank] |
    And Admin check announcement list
      | id      | title       | announceTo | startDate   | stopDate |
      | [blank] | Auto test 1 | Buyer      | currentDate | Plus1    |
    And Admin search announcement
      | title   | body    | announcementTo | from    |
      | [blank] | [blank] | Vendor         | [blank] |
    And Admin check announcement list
      | id      | title       | announceTo | startDate   | stopDate |
      | [blank] | Auto test 2 | Vendor     | currentDate | Plus1    |
    And Admin search announcement
      | title   | body    | announcementTo | from        |
      | [blank] | [blank] | [blank]        | currentDate |
    And Admin check announcement list
      | id      | title       | announceTo | startDate   | stopDate |
      | [blank] | Auto test 2 | Vendor     | currentDate | Plus1    |
      | [blank] | Auto test 1 | Buyer      | currentDate | Plus1    |
    And Admin search announcement
      | title       | body    | announcementTo | from        |
      | Auto test 2 | [blank] | Buyer          | currentDate |
    And Admin check no data found
    And Admin search announcement
      | title       | body    | announcementTo | from        |
      | Auto test 1 | [blank] | Vendor         | currentDate |
    And Admin check no data found
    And Admin search announcement
      | title       | body                     | announcementTo | from    |
      | Auto test 2 | Auto test announcement 1 | [blank]        | [blank] |
    And Admin check no data found

  @AD_ANNOUNCEMENT_8
  Scenario: Check display of a new created announcement on Buyer, Vendor, LP
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao8@podfoods.co | 12345678a |
    And Admin search announcements api
      | q[title]  | q[body] | q[recipient_type] | q[start_delivering_date] |
      | Auto test | [blank] | [blank]           | [blank]                  |
    And Admin delete announcements by api
    And Admin create announcements by api
      | name      | title       | body                   | recipient_type    | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test | Auto test 3 | Auto test announcement | logistics_partner | currentDate           | Plus1                | podfoods.co | podfoods.co |
    And Admin create announcements by api
      | name      | title       | body                   | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test | Auto test 2 | Auto test announcement | vendor         | currentDate           | Plus1                | podfoods.co | podfoods.co |

    Then Admin set region of announcements api
      | 26 |
    And Admin create announcements by api
      | name      | title       | body                   | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test | Auto test 4 | Auto test announcement | buyer          | currentDate           | Plus1                | podfoods.co | podfoods.co |
    Then Admin clear region of announcements api
    And Admin create announcements by api
      | name      | title       | body                   | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test | Auto test 1 | Auto test announcement | all_users      | currentDate           | Plus1                | podfoods.co | podfoods.co |
    Then Admin set region of announcements api
      | 58 |
    And Admin create announcements by api
      | name      | title       | body                   | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test | Auto test 5 | Auto test announcement | buyer          | currentDate           | Plus1                | podfoods.co | podfoods.co |


  @AD_ANNOUNCEMENT_8
  Scenario Outline: Check display of a new created announcement on Buyer, Vendor
    Given <role> open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer check announcement is "<status>"
      | title   | description   | link   |
      | <title> | <description> | <link> |
    Examples:
      | role_            | buyer                            | pass      | role       | status  | title       | description            | link        |
      | Vendor           | ngoctx+autovendor36@podfoods.co  | 12345678a | vendor     | showing | Auto test 2 | Auto test announcement | podfoods.co |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | showing | Auto test 4 | Auto test announcement | podfoods.co |
      | Store sub buyer  | ngoctx+autobuyer61@podfoods.co   | 12345678a | buyer      | showing | Auto test 4 | Auto test announcement | podfoods.co |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      | showing | Auto test 1 | Auto test announcement | podfoods.co |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head_buyer | showing | Auto test 4 | Auto test announcement | podfoods.co |

  @AD_ANNOUNCEMENT_8
  Scenario Outline: Check display of a new created announcement on LP
    Given LP open web LP
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer check announcement is "<status>"
      | title   | description   | link   |
      | <title> | <description> | <link> |
    Examples:
      | role_ | buyer                  | pass      | role | status  | title       | description            | link        |
      | LP    | ngoctx+lp1@podfoods.co | 12345678a | LP   | showing | Auto test 3 | Auto test announcement | podfoods.co |

  @AD_ANNOUNCEMENT_0
  Scenario: Clear data
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao8@podfoods.co | 12345678a |
    And Admin search announcements api
      | q[title]  | q[body] | q[recipient_type] | q[start_delivering_date] |
      | Auto test | [blank] | [blank]           | [blank]                  |
    And Admin delete announcements by api