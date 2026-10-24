inherited frmCadMetasValorPedCom: TfrmCadMetasValorPedCom
  Width = 632
  Height = 575
  Caption = 'Metas  de Pedido de Compra por Comprador'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 632
  ExplicitHeight = 575
  PixelsPerInch = 96
  TextHeight = 14
  object pnlPeriodo: TPanel [0]
    Left = 0
    Top = 0
    Width = 626
    Height = 36
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 10
      Width = 46
      Height = 14
      Caption = 'Per'#237'odo:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblEmpres: TLabel
      Left = 127
      Top = 10
      Width = 55
      Height = 14
      Caption = 'Empresa: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object mskDta: TMaskEditFocus
      Tag = 99
      Left = 67
      Top = 7
      Width = 54
      Height = 22
      EditMask = '99/9999'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = '  /    '
      OnExit = mskDtaExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesEmp: TEditFocus
      Tag = 99
      Left = 228
      Top = 7
      Width = 222
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      MaxLength = 3
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 184
      Top = 7
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object btnConfirmaPeriodo: TBitBtnLocked
      Left = 456
      Top = 7
      Width = 85
      Height = 22
      Caption = '&Confirma'
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
      OnClick = btnConfirmaPeriodoClick
    end
  end
  inherited pnlBotoes: TPanel
    Top = 504
    Width = 626
    Height = 26
    TabOrder = 3
    ExplicitTop = 504
    ExplicitWidth = 626
    ExplicitHeight = 26
    object shpEdit: TShape [0]
      Left = 100
      Top = 6
      Width = 15
      Height = 15
      Brush.Color = clMoneyGreen
    end
    object Label6: TLabel [1]
      Left = 121
      Top = 7
      Width = 420
      Height = 14
      Caption = 
        'Indica o Comprador em Edi'#231#227'o. Precione F10 P/ Confirmar ou ESC P' +
        '/ Cancelar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 622
      Height = 22
      TabOrder = 1
      ExplicitWidth = 622
      ExplicitHeight = 22
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 93
        Height = 22
        Caption = '[ F10 ] Confirmar'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 548
      Top = 2
      Width = 76
      TabOrder = 0
      ExplicitLeft = 548
      ExplicitTop = 2
      ExplicitWidth = 76
    end
  end
  inherited pnlStatus: TPanel
    Top = 530
    Width = 626
    TabOrder = 5
    ExplicitTop = 530
    ExplicitWidth = 626
    inherited pnlNomeForm: TPanel
      Left = 455
      TabOrder = 1
      ExplicitLeft = 455
    end
    inherited pnlInfo: TPanel
      Width = 455
      TabOrder = 0
      ExplicitWidth = 455
    end
  end
  object pnlCadMPC: TPanel [3]
    Left = 0
    Top = 36
    Width = 626
    Height = 231
    Align = alClient
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 1
    object cxgCadMPC: TcxGrid
      Left = 1
      Top = 1
      Width = 624
      Height = 229
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgCadMPCView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgCadMPCViewCustomDrawCell
        DataController.DataSource = dtsCadMPC
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '  '
        OptionsView.GroupByBox = False
        object cxgCadMPCViewCODOPE: TcxGridDBColumn
          DataBinding.FieldName = 'CODOPE'
          Options.Editing = False
          Options.Focusing = False
          Width = 100
        end
        object cxgCadMPCViewNOMOPE: TcxGridDBColumn
          DataBinding.FieldName = 'NOMOPE'
          Options.Editing = False
          Options.Focusing = False
          Width = 390
        end
        object cxgCadMPCViewTOTMET: TcxGridDBColumn
          DataBinding.FieldName = 'TOTMET'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Width = 110
        end
      end
      object cxgCliCnd: TcxGridLevel
        GridView = cxgCadMPCView
      end
    end
  end
  object pnlDetMPC: TPanel [4]
    Left = 0
    Top = 284
    Width = 626
    Height = 220
    Align = alBottom
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 2
    object cxgDetMPC: TcxGrid
      Left = 1
      Top = 1
      Width = 624
      Height = 185
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgDetMPCView: TcxGridDBTableView
        OnKeyDown = cxgDetMPCViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDetMPC
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        NewItemRow.InfoText = 'Clique aqui para Inserir um Novo Registro'
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '  '
        OptionsView.GroupByBox = False
        object cxgDetMPCViewCODFOR: TcxGridDBColumn
          DataBinding.FieldName = 'CODFOR'
          Options.Editing = False
          Options.Focusing = False
          Width = 100
        end
        object cxgDetMPCViewNOMFOR: TcxGridDBColumn
          DataBinding.FieldName = 'NOMFOR'
          Options.Editing = False
          Options.Focusing = False
          Width = 390
        end
        object cxgDetMPCViewPERFOR: TcxGridDBColumn
          DataBinding.FieldName = 'PERFOR'
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Width = 110
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxgDetMPCView
      end
    end
    object pnlFornecedor: TPanel
      Left = 1
      Top = 186
      Width = 624
      Height = 33
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label2: TLabel
        Left = 4
        Top = 9
        Width = 67
        Height = 14
        Caption = 'Fornecedor:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 484
        Top = 9
        Width = 29
        Height = 14
        Caption = 'Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 385
        Top = 9
        Width = 49
        Height = 14
        Caption = 'Percent.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtDesFor: TEditFocus
        Tag = 99
        Left = 133
        Top = 6
        Width = 246
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        MaxLength = 3
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttInteiro
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 77
        Top = 6
        Width = 55
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 8
        TabOrder = 0
        OnEnter = edtCodForEnter
        OnExit = edtCodForExit
        OnKeyPress = edtCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttInteiro
      end
      object edtTotPer: TEditFocus
        Tag = 99
        Left = 519
        Top = 6
        Width = 79
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtPerFor: TEditFocus
        Tag = 99
        Left = 440
        Top = 6
        Width = 38
        Height = 22
        Alignment = taRightJustify
        MaxLength = 5
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 267
    Width = 626
    Height = 17
    Align = alBottom
    Caption = 'Fornecedores'
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 562
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 534
    Top = 56
  end
  object cdsCadMPC: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterPost = cdsCadMPCAfterPost
    AfterScroll = cdsCadMPCAfterScroll
    Left = 340
    Top = 70
    object cdsCadMPCCODOPE: TStringField
      DisplayLabel = 'C'#243'd. Comprador'
      FieldName = 'CODOPE'
      Size = 3
    end
    object cdsCadMPCNOMOPE: TStringField
      DisplayLabel = 'Nome Comprador'
      FieldName = 'NOMOPE'
      Size = 30
    end
    object cdsCadMPCTOTMET: TFloatField
      DisplayLabel = 'Meta'
      FieldName = 'TOTMET'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object dtsCadMPC: TDataSource
    DataSet = cdsCadMPC
    Left = 310
    Top = 70
  end
  object cdsDetMPC: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterPost = cdsDetMPCAfterPost
    AfterDelete = cdsDetMPCAfterDelete
    Left = 350
    Top = 320
    object cdsDetMPCCODFOR: TStringField
      DisplayLabel = 'C'#243'd. Fornecedor'
      FieldName = 'CODFOR'
      Size = 8
    end
    object cdsDetMPCNOMFOR: TStringField
      DisplayLabel = 'Nome Fornecedor'
      FieldName = 'NOMFOR'
      Size = 60
    end
    object cdsDetMPCPERFOR: TFloatField
      DisplayLabel = 'Percentual'
      FieldName = 'PERFOR'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object dtsDetMPC: TDataSource
    DataSet = cdsDetMPC
    Left = 320
    Top = 320
  end
  object cxHint: TcxHintStyleController
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Tahoma'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -11
    HintStyle.Font.Name = 'Tahoma'
    HintStyle.Font.Style = []
    Left = 152
    Top = 339
  end
end
