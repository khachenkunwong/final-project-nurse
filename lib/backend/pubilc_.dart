final url = "https://373a-2403-6200-8958-4ca2-8850-bb85-f976-490e.ap.ngrok.io";
const productsGraphQL = """
query ExampleQuery {
  notifications {
    _id
  }
}
""";
const changMyDutyGraphQL = r"""
query Notifications($filter: JSON) {
  notifications(filter: $filter) {
    _id
    approve_by {
      frist_name
      last_name
    }
    user {
      _id,
      frist_name
      last_name
    }
    fields
    noift
  }
}""";

const sendLeave = r"""mutation CreateLeave($input: CreateLeaveInput!) {
  createLeave(input: $input)
}""";

const nameAll = r"""
query Users {
  users {
    _id
    frist_name
    last_name
    actor
    groups {
      name_group
    }
  }
}
""";

const shownotificationLeave = r"""
query Notifications($filter: JSON) {
  notifications(filter: $filter) {
    type
    _id
    fields
    noift
  }
}
""";

const getchangduty = r"""
query Query($filter: JSON) {
  notifications(filter: $filter) {
    _id
    type
    fields
    approve_by {
      frist_name
      last_name
      actor
    }
    noift
    user {
      frist_name
      last_name
    }
  }
}
""";

