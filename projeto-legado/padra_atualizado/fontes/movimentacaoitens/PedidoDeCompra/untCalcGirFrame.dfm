object fraCalcGirFrame: TfraCalcGirFrame
  Left = 0
  Top = 0
  Width = 987
  Height = 253
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object gpbCalculoSugestao: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    Caption = 'C'#225'lculo da Quantidade de Sugest'#227'o:'
    ParentFont = False
    Style.BorderColor = clBlack
    Style.BorderStyle = ebsUltraFlat
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = 14
    Style.Font.Name = 'Arial'
    Style.Font.Pitch = fpVariable
    Style.Font.Style = []
    Style.LookAndFeel.Kind = lfUltraFlat
    Style.LookAndFeel.NativeStyle = False
    Style.Shadow = True
    Style.IsFontAssigned = True
    StyleDisabled.LookAndFeel.Kind = lfUltraFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    TabOrder = 0
    ExplicitHeight = 251
    Height = 253
    Width = 987
    object lblConsiderar: TLabel
      Left = 18
      Top = 233
      Width = 71
      Height = 14
      Caption = 'Considerar at'#233
      Enabled = False
    end
    object lblDiasPrev: TLabel
      Left = 148
      Top = 233
      Width = 194
      Height = 14
      Caption = 'dias de previs'#227'o para pedidos de venda'
      Enabled = False
    end
    object lblLinkEmpresas: TLabel
      Left = 371
      Top = 117
      Width = 58
      Height = 14
      Caption = '(Empresas)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsItalic]
      ParentFont = False
      Visible = False
      OnClick = lblLinkEmpresasClick
    end
    object Label1: TLabel
      Left = 449
      Top = 113
      Width = 283
      Height = 14
      Caption = ' ( Est.Min = 0, Est.M'#225'x = 0, Saldo B'#225'sico para Compra < 0 )'
    end
    object chkMultCompra: TCheckBox
      Left = 18
      Top = 15
      Width = 167
      Height = 14
      Caption = 'Considerar m'#250'ltiplo de compra'
      TabOrder = 0
      OnClick = chkMultCompraClick
    end
    object chkEstMin: TCheckBox
      Left = 18
      Top = 45
      Width = 225
      Height = 14
      Caption = 'Considerar estoque m'#237'nimo para sugest'#227'o'
      TabOrder = 2
      OnClick = chkEstMinClick
    end
    object chkEstMax: TCheckBox
      Left = 18
      Top = 75
      Width = 375
      Height = 14
      Caption = 
        'Limitar quantidade de sugest'#227'o no estoque m'#225'ximo, quando ultrapa' +
        'ssar'
      TabOrder = 4
      OnClick = chkEstMaxClick
    end
    object chkPedPen: TCheckBox
      Left = 18
      Top = 105
      Width = 375
      Height = 14
      Caption = 'Considerar pedidos de compra pendentes para sugest'#227'o'
      TabOrder = 6
      OnClick = chkPedPenClick
    end
    object chkCotAbe: TCheckBox
      Left = 18
      Top = 150
      Width = 297
      Height = 14
      Caption = 'Considerar cota'#231#245'es em aberto para sugest'#227'o'
      TabOrder = 9
    end
    object chkTransf: TCheckBox
      Left = 18
      Top = 165
      Width = 359
      Height = 14
      Caption = 'Considerar solicita'#231#245'es de transfer'#234'ncias pendentes na sugest'#227'o'
      TabOrder = 10
    end
    object chkGarPen: TCheckBox
      Left = 18
      Top = 180
      Width = 342
      Height = 14
      Caption = 'Considerar Garantia Pendente no saldo do produto para sugest'#227'o'
      TabOrder = 11
    end
    object chkPedVen: TCheckBox
      Left = 18
      Top = 195
      Width = 297
      Height = 14
      Caption = 'Considerar pedidos de venda pendentes para sugest'#227'o'
      TabOrder = 12
      OnClick = chkPedVenClick
    end
    object edtDiaPre: TEditFocus
      Tag = 99
      Left = 95
      Top = 225
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 4
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object chkOrdPro: TCheckBox
      Left = 434
      Top = 11
      Width = 386
      Height = 14
      Caption = 'Considerar Ordem de Produ'#231#227'o no saldo do produto para sugest'#227'o'
      TabOrder = 15
    end
    object chkArredQtdeSugest: TCheckBox
      Left = 434
      Top = 57
      Width = 217
      Height = 14
      Caption = 'Arredondar a quantidade de sugest'#227'o'
      TabOrder = 18
    end
    object grbPedMlj: TcxGroupBox
      Left = 434
      Top = 145
      Caption = 'Agrupamento da sugest'#227'o:'
      ParentFont = False
      Style.BorderColor = clBlack
      Style.BorderStyle = ebsUltraFlat
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = 14
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = []
      Style.LookAndFeel.Kind = lfUltraFlat
      Style.LookAndFeel.NativeStyle = False
      Style.Shadow = False
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.Kind = lfUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      TabOrder = 20
      Height = 84
      Width = 506
      object chkAgrEmp: TCheckBox
        Left = 15
        Top = 18
        Width = 223
        Height = 14
        Caption = 'Agrupar quantidade sugerida na empresa:'
        TabOrder = 0
        OnClick = chkAgrEmpClick
      end
      object rdgSugInd: TRadioGroup
        Left = 15
        Top = 37
        Width = 194
        Height = 39
        Caption = 'No agrupamento, calcular sugest'#227'o:'
        Columns = 2
        Enabled = False
        ItemIndex = 0
        Items.Strings = (
          'por empresa'
          'global')
        TabOrder = 2
      end
      object cbxAbrEmp: TComboBoxFocus
        Tag = 99
        Left = 240
        Top = 14
        Width = 253
        Height = 22
        Style = csDropDownList
        Enabled = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object chkPonPed: TCheckBox
      Left = 18
      Top = 60
      Width = 225
      Height = 14
      Caption = 'Considerar ponto de pedido para sugest'#227'o'
      TabOrder = 3
      OnClick = chkPonPedClick
    end
    object chkAteMax: TCheckBox
      Left = 18
      Top = 90
      Width = 375
      Height = 14
      Caption = 'Calcular sugest'#227'o at'#233' o estoque m'#225'ximo'
      TabOrder = 5
      OnClick = chkAteMaxClick
    end
    object chkAgrSim: TCheckBox
      Left = 434
      Top = 72
      Width = 356
      Height = 14
      Caption = 'Agrupar similares no produto principal'
      TabOrder = 19
    end
    object chkPedPenTransferencia: TCheckBox
      Left = 39
      Top = 119
      Width = 330
      Height = 14
      Caption = 'Subtrair pedidos de compra de transfer'#234'ncia do total de pedidos'
      TabOrder = 7
      OnClick = chkPedPenTransferenciaClick
    end
    object chkEndere: TCheckBox
      Left = 18
      Top = 210
      Width = 297
      Height = 14
      Caption = 'Considerar estoque parado no endere'#231'amento de entrada'
      TabOrder = 13
    end
    object chkConsRequisicao: TCheckBox
      Left = 434
      Top = 87
      Width = 256
      Height = 14
      Caption = 'Considerar Requisi'#231#227'o Em Aberto para Sugest'#227'o'
      TabOrder = 21
    end
    object chkMultiploAposCentralizar: TCheckBox
      Left = 39
      Top = 30
      Width = 378
      Height = 14
      Caption = 
        'Para compra centralizada, calcular o m'#250'ltiplo ap'#243's centralizar a' +
        '  compra'
      TabOrder = 1
    end
    object rdgEntFut: TGroupBox
      Left = 691
      Top = 29
      Width = 275
      Height = 54
      Caption = 'Deduzir do saldo base para compra, entregas futuras:'
      TabOrder = 22
      object chkPrevisao: TCheckBox
        Left = 16
        Top = 17
        Width = 97
        Height = 14
        Caption = 'Previs'#227'o'
        TabOrder = 0
      end
      object chkFalta: TCheckBox
        Left = 16
        Top = 32
        Width = 106
        Height = 14
        Caption = 'Falta de Produto'
        TabOrder = 1
      end
      object chkAguarda: TCheckBox
        Left = 128
        Top = 17
        Width = 139
        Height = 14
        Caption = 'Aguardando Cliente'
        TabOrder = 2
      end
    end
    object chkVenEsp: TCheckBox
      Left = 434
      Top = 102
      Width = 541
      Height = 14
      Caption = 
        'Exibir somente os '#237'tens de venda espor'#225'dica se estiverem com sal' +
        'do l'#237'quido devedor'
      TabOrder = 23
    end
    object rdgTipCalVenPer: TRadioGroup
      Left = 441
      Top = 25
      Width = 244
      Height = 31
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Quantidade'
        'M'#233'dia')
      TabOrder = 17
    end
    object chkVenPer: TCheckBox
      Left = 434
      Top = 26
      Width = 236
      Height = 14
      Caption = 'Considerar vendas perdidas para sugest'#227'o'
      TabOrder = 16
    end
    object chkDecSalExt: TCheckBox
      Left = 435
      Top = 130
      Width = 378
      Height = 14
      Caption = 'Deduzir a quantidade de Estoque Externo do Estoque do Produto'
      TabOrder = 24
    end
    object chkPedGar: TCheckBox
      Left = 39
      Top = 134
      Width = 330
      Height = 14
      Caption = 'Subtrair pedidos de compra gerados pelo processo de garantia'
      TabOrder = 8
      OnClick = chkPedPenTransferenciaClick
    end
  end
  object cdsEmpSel: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsEmpSelBeforePost
    Left = 864
    Top = 155
    object cdsEmpSelCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsEmpSelDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 40
    end
    object cdsEmpSelMARDES: TStringField
      FieldName = 'MARDES'
      Size = 1
    end
    object cdsEmpSelEMPVIS: TStringField
      FieldName = 'EMPVIS'
      Size = 1
    end
  end
  object cdsEmpSubtraiTansf: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 916
    Top = 83
    object StringField1: TStringField
      FieldName = 'EMP_CODEMP'
      Size = 3
    end
    object StringField2: TStringField
      FieldName = 'EMP_NOMEMP'
      Size = 40
    end
    object StringField3: TStringField
      FieldName = 'MARDES'
      Size = 1
    end
  end
end
