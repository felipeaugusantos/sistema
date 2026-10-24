object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Demo API Yapay'
  ClientHeight = 393
  ClientWidth = 573
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxLayoutControl1: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 573
    Height = 393
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 510
    object BtnEnviarCobranca: TcxButton
      Left = 10000
      Top = 10000
      Width = 373
      Height = 25
      Caption = 'Enviar Cobran'#231'a'
      TabOrder = 18
      Visible = False
      OnClick = BtnEnviarCobrancaClick
    end
    object cbAmbiente: TcxComboBox
      Left = 10000
      Top = 10000
      Properties.Items.Strings = (
        'Sandbox'
        'Produ'#231#227'o')
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 0
      Text = 'Sandbox'
      Visible = False
      Width = 121
    end
    object edtEnviarAccess_token: TcxTextEdit
      Left = 10000
      Top = 10000
      TabStop = False
      Properties.ReadOnly = True
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.Color = clBtnFace
      Style.HotTrack = False
      TabOrder = 8
      Text = 'edtEnviarAccess_token'
      Visible = False
      Width = 236
    end
    object edtCustomer_email: TcxTextEdit
      Left = 10000
      Top = 10000
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 9
      Text = 'edtCustomer_email'
      Visible = False
      Width = 236
    end
    object edtOrder_number: TcxCurrencyEdit
      Left = 10000
      Top = 10000
      Properties.DisplayFormat = '0'
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 10
      Visible = False
      Width = 121
    end
    object edtCode: TcxCurrencyEdit
      Left = 10000
      Top = 10000
      Properties.DisplayFormat = '0'
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 11
      Visible = False
      Width = 121
    end
    object edtValue: TcxCurrencyEdit
      Left = 10000
      Top = 10000
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 12
      Visible = False
      Width = 121
    end
    object edtDescription: TcxTextEdit
      Left = 10000
      Top = 10000
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 13
      Text = 'edtDescription'
      Visible = False
      Width = 236
    end
    object edtMax_split_transaction: TcxSpinEdit
      Left = 10000
      Top = 10000
      Properties.Alignment.Horz = taRightJustify
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      TabOrder = 14
      Value = 1
      Visible = False
      Width = 121
    end
    object cbAvailable_payment_methods: TcxCheckComboBox
      Left = 10000
      Top = 10000
      Properties.Items = <
        item
        end>
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 15
      Visible = False
      Width = 236
    end
    object cbUse_cards: TcxCheckBox
      Left = 10000
      Top = 10000
      Caption = 'Use cards'
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 17
      Visible = False
    end
    object cbNew_checkout: TcxCheckBox
      Left = 10000
      Top = 10000
      Caption = 'New Checkout'
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 16
      Visible = False
    end
    object edtTokenAccount: TcxTextEdit
      Left = 10000
      Top = 10000
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 4
      Text = 'edtTokenAccount'
      Visible = False
      Width = 351
    end
    object edtConsumerKey: TcxTextEdit
      Left = 10000
      Top = 10000
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 1
      Text = 'edtConsumerKey'
      Visible = False
      Width = 351
    end
    object edtConsumerSecret: TcxTextEdit
      Left = 10000
      Top = 10000
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 2
      Text = 'edtConsumerSecret'
      Visible = False
      Width = 351
    end
    object edtResellerToken: TcxTextEdit
      Left = 10000
      Top = 10000
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 3
      Text = 'edtResellerToken'
      Visible = False
      Width = 351
    end
    object cbTypeResponse: TcxComboBox
      Left = 10000
      Top = 10000
      Enabled = False
      Properties.Items.Strings = (
        'JSON'
        'XML')
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 5
      Text = 'JSON'
      Visible = False
      Width = 121
    end
    object cbDebug: TcxCheckBox
      Left = 10000
      Top = 10000
      Caption = 'Debug'
      State = cbsChecked
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 6
      Visible = False
    end
    object cbLog: TcxCheckBox
      Left = 10000
      Top = 10000
      Caption = 'Arquivo Log'
      State = cbsChecked
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 7
      Visible = False
    end
    object edtConsultaAccess_token: TcxTextEdit
      Left = 10000
      Top = 10000
      TabStop = False
      Properties.ReadOnly = True
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.Color = clBtnFace
      Style.HotTrack = False
      TabOrder = 19
      Text = 'edtConsultaAccess_token'
      Visible = False
      Width = 431
    end
    object BtnConsultaCobranca: TcxButton
      Left = 10000
      Top = 10000
      Width = 501
      Height = 25
      Caption = 'Consultar Cobran'#231'a'
      TabOrder = 21
      Visible = False
      OnClick = BtnConsultaCobrancaClick
    end
    object EdtConsultaIdCobranca: TcxCurrencyEdit
      Left = 10000
      Top = 10000
      EditValue = 0
      Properties.DecimalPlaces = 0
      Properties.DisplayFormat = '0'
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 20
      Visible = False
      Width = 431
    end
    object EdtInativarIdCobranca: TcxCurrencyEdit
      Left = 10000
      Top = 10000
      EditValue = 0
      Properties.DisplayFormat = '0'
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 26
      Visible = False
      Width = 431
    end
    object BtnInativarCobranca: TcxButton
      Left = 10000
      Top = 10000
      Width = 501
      Height = 25
      Caption = 'Inativar Cobran'#231'a'
      TabOrder = 27
      Visible = False
      OnClick = BtnInativarCobrancaClick
    end
    object edtInativarAccess_token: TcxTextEdit
      Left = 10000
      Top = 10000
      TabStop = False
      Properties.ReadOnly = True
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.Color = clBtnFace
      Style.HotTrack = False
      TabOrder = 25
      Text = 'edtInativarAccess_token'
      Visible = False
      Width = 431
    end
    object edtConsultaAccess_token2: TcxTextEdit
      Left = 106
      Top = 62
      TabStop = False
      Properties.ReadOnly = True
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.Color = clBtnFace
      Style.HotTrack = False
      TabOrder = 22
      Text = 'edtConsultaAccess_token2'
      Width = 431
    end
    object EdtConsultaIdTransacao: TcxCurrencyEdit
      Left = 106
      Top = 89
      Properties.DecimalPlaces = 0
      Properties.DisplayFormat = '0'
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 23
      Width = 431
    end
    object BtnConsultaTransacao: TcxButton
      Left = 36
      Top = 116
      Width = 501
      Height = 25
      Caption = 'Consultar Transa'#231#227'o'
      TabOrder = 24
      OnClick = BtnConsultaTransacaoClick
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avTop
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object liAmbiente: TdxLayoutItem
      Parent = lgConexao
      CaptionOptions.Text = 'Ambiente:'
      Control = cbAmbiente
      ControlOptions.AlignHorz = ahLeft
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object lgOperacao: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.Text = 'Opera'#231#227'o'
      ButtonOptions.Buttons = <>
      ItemIndex = 3
      LayoutDirection = ldTabbed
      Index = 0
    end
    object lgEnviarCobranca: TdxLayoutGroup
      Parent = lgOperacao
      CaptionOptions.Text = 'Enviar Cobran'#231'a'
      ButtonOptions.Buttons = <>
      ItemIndex = 10
      Index = 1
    end
    object liedtAccess_token: TdxLayoutItem
      Parent = lgEnviarCobranca
      CaptionOptions.Text = 'Access Token'
      Control = edtEnviarAccess_token
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liedtCustomer_email: TdxLayoutItem
      Parent = lgEnviarCobranca
      CaptionOptions.Text = 'Customer Email'
      Control = edtCustomer_email
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liedtOrder_number: TdxLayoutItem
      Parent = lgEnviarCobranca
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Order Number'
      Control = edtOrder_number
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liedtCode: TdxLayoutItem
      Parent = lgEnviarCobranca
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Code'
      Control = edtCode
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object liedtValue: TdxLayoutItem
      Parent = lgEnviarCobranca
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Value'
      Control = edtValue
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object liedtDescription: TdxLayoutItem
      Parent = lgEnviarCobranca
      CaptionOptions.Text = 'Description'
      Control = edtDescription
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object liedtMax_split_transaction: TdxLayoutItem
      Parent = lgEnviarCobranca
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Max Split Transaction'
      Control = edtMax_split_transaction
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 6
    end
    object licbAvailable_payment_methods: TdxLayoutItem
      Parent = lgEnviarCobranca
      CaptionOptions.Text = 'Available Payment Methods'
      Control = cbAvailable_payment_methods
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object licbUse_cards: TdxLayoutItem
      Parent = lgEnviarCobranca
      CaptionOptions.Text = 'cxCheckBox1'
      CaptionOptions.Visible = False
      Control = cbUse_cards
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 88
      ControlOptions.ShowBorder = False
      Index = 9
    end
    object licbNew_checkout: TdxLayoutItem
      Parent = lgEnviarCobranca
      CaptionOptions.Text = 'cxCheckBox2'
      CaptionOptions.Visible = False
      Control = cbNew_checkout
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 88
      ControlOptions.ShowBorder = False
      Index = 8
    end
    object liBtnEnviarCobranca: TdxLayoutItem
      Parent = lgEnviarCobranca
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = BtnEnviarCobranca
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 10
    end
    object liedtTokenAccount: TdxLayoutItem
      Parent = lgConexao
      CaptionOptions.Text = 'Token Account'
      Control = edtTokenAccount
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object lgConexao: TdxLayoutGroup
      Parent = lgOperacao
      CaptionOptions.Text = 'Conex'#227'o'
      ButtonOptions.Buttons = <>
      ItemIndex = 7
      Index = 0
    end
    object liedtConsumerKey: TdxLayoutItem
      Parent = lgConexao
      CaptionOptions.Text = 'Consumer Key'
      Control = edtConsumerKey
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liedtConsumerSecret: TdxLayoutItem
      Parent = lgConexao
      CaptionOptions.Text = 'Consumer Secret'
      Control = edtConsumerSecret
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liedtResellerToken: TdxLayoutItem
      Parent = lgConexao
      CaptionOptions.Text = 'Reseller Token'
      Control = edtResellerToken
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object licbTypeResponse: TdxLayoutItem
      Parent = lgConexao
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Type Response'
      Control = cbTypeResponse
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Enabled = False
      Index = 5
    end
    object licbDebug: TdxLayoutItem
      Parent = lgConexao
      CaptionOptions.Text = 'cxCheckBox1'
      CaptionOptions.Visible = False
      Control = cbDebug
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 88
      ControlOptions.ShowBorder = False
      Index = 6
    end
    object licbLog: TdxLayoutItem
      Parent = lgConexao
      CaptionOptions.Text = 'cxCheckBox2'
      CaptionOptions.Visible = False
      Control = cbLog
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 88
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object lgConsultarCobranca: TdxLayoutGroup
      Parent = lgOperacao
      CaptionOptions.Text = 'Consultar Cobran'#231'a'
      ButtonOptions.Buttons = <>
      ItemIndex = 2
      Index = 2
    end
    object lgInativarCobranca: TdxLayoutGroup
      Parent = lgOperacao
      CaptionOptions.Text = 'Inativar Cobran'#231'a'
      ButtonOptions.Buttons = <>
      Index = 4
    end
    object liedtConsultaAccess_token: TdxLayoutItem
      Parent = lgConsultarCobranca
      CaptionOptions.Text = 'Access Token'
      Control = edtConsultaAccess_token
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liBtnConsultaCobranca: TdxLayoutItem
      Parent = lgConsultarCobranca
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = BtnConsultaCobranca
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liEdtIdCobranca: TdxLayoutItem
      Parent = lgConsultarCobranca
      CaptionOptions.Text = 'Id Cobran'#231'a'
      Control = EdtConsultaIdCobranca
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liedtInativaAccess_token: TdxLayoutItem
      Parent = lgInativarCobranca
      CaptionOptions.Text = 'Access Token'
      Control = edtInativarAccess_token
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 318
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liEdtInativaIdCobranca: TdxLayoutItem
      Parent = lgInativarCobranca
      CaptionOptions.Text = 'Id Cobran'#231'a'
      Control = EdtInativarIdCobranca
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 303
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liBtnInativaCobranca: TdxLayoutItem
      Parent = lgInativarCobranca
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = BtnInativarCobranca
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 373
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object lgListagemTransacoes: TdxLayoutGroup
      Parent = lgOperacao
      CaptionOptions.Text = 'Listagem de Transa'#231#245'es'
      ButtonOptions.Buttons = <>
      ItemIndex = 1
      Index = 3
    end
    object liedtConsultaAccess_token2: TdxLayoutItem
      Parent = lgListagemTransacoes
      CaptionOptions.Text = 'Access Token'
      Control = edtConsultaAccess_token2
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 446
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem2: TdxLayoutItem
      Parent = lgListagemTransacoes
      CaptionOptions.Text = 'Id Transa'#231#227'o'
      Control = EdtConsultaIdTransacao
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItem1: TdxLayoutItem
      Parent = lgListagemTransacoes
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = BtnConsultaTransacao
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 2
    end
  end
end
