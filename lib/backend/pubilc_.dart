final url = "https://47c2-2001-44c8-45c3-9d2f-792f-287d-be0-f783.ap.ngrok.io";
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

