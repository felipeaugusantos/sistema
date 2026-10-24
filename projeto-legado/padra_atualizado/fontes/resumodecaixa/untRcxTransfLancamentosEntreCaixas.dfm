inherited frmRcxTransfLancamentosEntreCaixas: TfrmRcxTransfLancamentosEntreCaixas
  Width = 984
  Height = 612
  BorderIcons = [biSystemMenu]
  Caption = 'Transfer'#234'ncia de Lan'#231'amentos entre Caixas'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 984
  ExplicitHeight = 612
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 539
    Width = 978
    ExplicitTop = 539
    ExplicitWidth = 978
    inherited FlwBotoes: TFlowPanel
      Width = 974
      ExplicitTop = 2
      ExplicitWidth = 974
      ExplicitHeight = 24
      object BtnMarcarTodos: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 126
        Height = 21
        Caption = '[ F7 ] Marcar Todos'
        TabOrder = 0
        OnClick = BtnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 126
        Top = 0
        Width = 120
        Height = 21
        Caption = '[ F8 ] Desmarcar Todos'
        TabOrder = 1
        OnClick = btnDesmarcarTodosClick
      end
      object btnConfirmar: TBitBtnLocked
        Left = 246
        Top = 0
        Width = 105
        Height = 21
        Caption = '[ F10 ] Confirmar'
        TabOrder = 2
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 898
      ExplicitLeft = 898
    end
  end
  inherited pnlStatus: TPanel
    Top = 567
    Width = 978
    TabOrder = 4
    ExplicitTop = 567
    ExplicitWidth = 978
    inherited pnlNomeForm: TPanel
      Left = 676
      Width = 302
      ExplicitLeft = 676
      ExplicitWidth = 302
    end
    inherited pnlInfo: TPanel
      Width = 676
      ExplicitWidth = 676
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 978
    Height = 84
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    object Label2: TLabel
      Left = 9
      Top = 57
      Width = 114
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data dos Lan'#231'amentos:'
    end
    object Label1: TLabel
      Left = 56
      Top = 12
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Caixa Origem:'
    end
    object Label3: TLabel
      Left = 74
      Top = 34
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
    end
    object edtDataLancamentos: TcxDateEdit
      Tag = 99
      Left = 125
      Top = 53
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 2
      Width = 89
    end
    object edtCodigoCaixa: TEditFocus
      Tag = 99
      Left = 125
      Top = 9
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodigoCaixaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDescricaoCaixa: TEditFocus
      Left = 193
      Top = 9
      Width = 350
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodigoOperador: TEditFocus
      Tag = 99
      Left = 125
      Top = 31
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomeOperador: TEditFocus
      Left = 193
      Top = 31
      Width = 350
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnCarregarLancamentos: TBitBtnLocked
      Left = 544
      Top = 54
      Width = 145
      Height = 22
      Align = alCustom
      Caption = '&Carregar Lan'#231'amentos'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 3
      OnClick = btnCarregarLancamentosClick
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 84
    Width = 978
    Height = 378
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    object grdLancamentos: TcxGridCitel
      Left = 2
      Top = 2
      Width = 974
      Height = 374
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdLancamentosDados: TcxGridDBTableViewCitel
        OnKeyDown = grdLancamentosDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = grdLancamentosDadosCustomDrawCell
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.FocusRect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdLancamentosDadosDOCUMENTO: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'DOCUMENTO'
          Width = 142
        end
        object grdLancamentosDadosRCX_SEQCON: TcxGridDBColumn
          Caption = 'Seq. Baixa'
          DataBinding.FieldName = 'RCX_SEQCON'
          Width = 79
        end
        object grdLancamentosDadosRCX_DESCRI: TcxGridDBColumn
          Caption = 'Hist'#243'rico'
          DataBinding.FieldName = 'RCX_DESCRI'
          Width = 218
        end
        object grdLancamentosDadosRCX_VALDOC: TcxGridDBColumn
          Caption = 'Valor Lan'#231'.'
          DataBinding.FieldName = 'RCX_VALDOC'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          Width = 83
        end
        object grdLancamentosDadosRCX_DINREC: TcxGridDBColumn
          Caption = 'Dinheiro'
          DataBinding.FieldName = 'RCX_DINREC'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          Width = 78
        end
        object grdLancamentosDadosRCX_CARREC: TcxGridDBColumn
          Caption = 'Cart'#227'o'
          DataBinding.FieldName = 'RCX_CARREC'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          Width = 76
        end
        object grdLancamentosDadosRCX_CHQAVI: TcxGridDBColumn
          Caption = 'Cheque '#224' vista'
          DataBinding.FieldName = 'RCX_CHQAVI'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          Width = 84
        end
        object grdLancamentosDadosRCX_CHQPRE: TcxGridDBColumn
          Caption = 'Cheque pr'#233'-datado'
          DataBinding.FieldName = 'RCX_CHQPRE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          Width = 104
        end
        object grdLancamentosDadosRCX_ORDREC: TcxGridDBColumn
          Caption = 'Ordem de Pgto.'
          DataBinding.FieldName = 'RCX_ORDREC'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00'
          Width = 84
        end
        object grdLancamentosDadosRCX_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'RCX_MARDES'
          Visible = False
        end
      end
      object grdLancamentosNivel: TcxGridLevel
        GridView = grdLancamentosDados
      end
    end
  end
  object pnlTotais: TPanel [5]
    Left = 0
    Top = 462
    Width = 978
    Height = 77
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label6: TLabel
      Left = 372
      Top = 25
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total:'
    end
    object Label9: TLabel
      Left = 329
      Top = 48
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Selecionados:'
    end
    object Label4: TLabel
      Left = 422
      Top = 7
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade '
    end
    object Label5: TLabel
      Left = 501
      Top = 7
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Lan'#231'. '
    end
    object Label7: TLabel
      Left = 596
      Top = 7
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dinheiro '
    end
    object Label8: TLabel
      Left = 682
      Top = 7
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cart'#227'o '
    end
    object Label10: TLabel
      Left = 721
      Top = 7
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque '#224' vista '
    end
    object Label11: TLabel
      Left = 816
      Top = 7
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque pr'#233' '
    end
    object Label12: TLabel
      Left = 878
      Top = 6
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ordem de pgto. '
    end
    object edtQtdLancamentos: TEditFocus
      Left = 400
      Top = 22
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValorLancamentos: TEditFocus
      Left = 479
      Top = 22
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdSelecionados: TEditFocus
      Left = 400
      Top = 45
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtLancamentosSel: TEditFocus
      Left = 479
      Top = 45
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDinheiro: TEditFocus
      Left = 558
      Top = 22
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDinheiroSel: TEditFocus
      Left = 558
      Top = 45
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCartao: TEditFocus
      Left = 637
      Top = 22
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCartaoSel: TEditFocus
      Left = 637
      Top = 45
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtChequeAVista: TEditFocus
      Left = 716
      Top = 22
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtChequeAVistaSel: TEditFocus
      Left = 716
      Top = 45
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtChequePre: TEditFocus
      Left = 795
      Top = 22
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtChequePreSel: TEditFocus
      Left = 795
      Top = 45
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtOrdemRecebimento: TEditFocus
      Left = 874
      Top = 22
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtOrdemRecebimentoSel: TEditFocus
      Left = 874
      Top = 45
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 240
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 224
    Top = 208
  end
end
