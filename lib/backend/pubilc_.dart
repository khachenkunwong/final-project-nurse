final url = "https://2e0f-2403-6200-8958-4ca2-dd53-4b82-a1b2-d960.ap.ngrok.io";
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
