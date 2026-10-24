inherited frmInfPedido: TfrmInfPedido
  Width = 646
  Height = 590
  BorderIcons = [biSystemMenu]
  Caption = 'Informa'#231#245'es do Pedido'
  Position = poMainFormCenter
  ExplicitWidth = 646
  ExplicitHeight = 590
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 640
    Height = 28
    Enabled = True
    Visible = True
    ExplicitTop = 417
    ExplicitWidth = 640
    ExplicitHeight = 28
    inherited FlwBotoes: TFlowPanel
      Width = 636
      Height = 24
      ExplicitWidth = 636
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 559
      Top = 3
      ExplicitLeft = 559
      ExplicitTop = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 640
    ExplicitTop = 445
    ExplicitWidth = 640
    inherited pnlNomeForm: TPanel
      Left = 469
      ExplicitLeft = 469
    end
    inherited pnlInfo: TPanel
      Width = 469
      ExplicitWidth = 469
    end
  end
  inherited pgcDados: TPageControl
    Width = 640
    Height = 517
    ExplicitWidth = 640
    ExplicitHeight = 417
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 632
      ExplicitHeight = 385
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 640
    Height = 517
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 3
    ExplicitHeight = 417
    object lbl1: TLabel
      Left = 8
      Top = 8
      Width = 62
      Height = 14
      Caption = 'Mensagem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblMen001: TDBText
      Left = 8
      Top = 26
      Width = 578
      Height = 17
      DataField = 'MEN001'
      DataSource = dtsInfo
    end
    object lblMen002: TDBText
      Left = 8
      Top = 45
      Width = 578
      Height = 17
      DataField = 'MEN002'
      DataSource = dtsInfo
    end
    object lbl4: TLabel
      Left = 8
      Top = 74
      Width = 65
      Height = 14
      Caption = 'Observa'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblObs001: TDBText
      Left = 8
      Top = 92
      Width = 578
      Height = 17
      DataField = 'MENEXP'
      DataSource = dtsInfo
    end
    object lblObs002: TDBText
      Left = 8
      Top = 111
      Width = 578
      Height = 17
      DataField = 'MENEX2'
      DataSource = dtsInfo
    end
    object lblObs003: TDBText
      Left = 8
      Top = 130
      Width = 578
      Height = 17
      DataField = 'MENEX3'
      DataSource = dtsInfo
    end
    object lblObs004: TDBText
      Left = 8
      Top = 149
      Width = 578
      Height = 17
      DataField = 'MENEX4'
      DataSource = dtsInfo
    end
    object lblObsExp: TDBText
      Left = 8
      Top = 168
      Width = 578
      Height = 17
      DataField = 'OBSEXP'
      DataSource = dtsInfo
    end
    object lbl10: TLabel
      Left = 8
      Top = 194
      Width = 85
      Height = 14
      Caption = 'Transportadora'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTransp: TDBText
      Left = 8
      Top = 212
      Width = 578
      Height = 17
      Color = 16770261
      DataField = 'NOMTRA'
      DataSource = dtsInfo
      ParentColor = False
    end
    object lbl12: TLabel
      Left = 8
      Top = 241
      Width = 116
      Height = 14
      Caption = 'N'#186' Pedido de Compra'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPedCmp: TDBText
      Left = 8
      Top = 259
      Width = 217
      Height = 17
      DataField = 'NUMCMP'
      DataSource = dtsInfo
    end
    object lbl14: TLabel
      Left = 231
      Top = 241
      Width = 61
      Height = 14
      Caption = 'N'#186' Registro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblRegist: TDBText
      Left = 231
      Top = 259
      Width = 404
      Height = 17
      Color = 16770261
      DataField = 'REGCON'
      DataSource = dtsInfo
      ParentColor = False
    end
    object lblBloqueio: TLabel
      Left = 2
      Top = 483
      Width = 636
      Height = 32
      Align = alBottom
      AutoSize = False
      Caption = 'Bloqueio'
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Visible = False
      WordWrap = True
      ExplicitLeft = 8
      ExplicitTop = 375
      ExplicitWidth = 623
    end
    object dbgItensPedCmp: TDBGridCitel
      Left = 2
      Top = 391
      Width = 636
      Height = 92
      Align = alBottom
      DataSource = dtsRastroPed
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'RTM_NUMDOC'
          Title.Caption = 'N'#186' Pedido'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RTM_NUMFAT'
          Title.Caption = 'N'#186' Nota Fiscal'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RTM_TIPFAT'
          Title.Caption = 'Esp'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RTM_EMPFAT'
          Title.Caption = 'Emp'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RTM_NUMREG'
          Title.Caption = 'N'#186' do Registro'
          Width = 135
          Visible = True
        end>
    end
    object gpbVenda: TGroupBox
      Left = 327
      Top = 287
      Width = 300
      Height = 98
      Caption = 'Venda'
      TabOrder = 1
      object lblSepara: TDBText
        AlignWithMargins = True
        Left = 5
        Top = 33
        Width = 290
        Height = 17
        Margins.Top = 0
        Align = alTop
        Color = 16770261
        DataField = 'SEPARA'
        DataSource = dtsInfo
        ParentColor = False
        ExplicitLeft = 7
        ExplicitTop = 28
        ExplicitWidth = 215
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 19
        Width = 290
        Height = 14
        Align = alTop
        Caption = 'Separador'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 57
      end
      object lblConfer: TDBText
        AlignWithMargins = True
        Left = 5
        Top = 70
        Width = 290
        Height = 17
        Margins.Top = 0
        Align = alTop
        DataField = 'CONFER'
        DataSource = dtsInfo
        ExplicitLeft = 24
        ExplicitTop = 81
        ExplicitWidth = 217
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 56
        Width = 290
        Height = 14
        Align = alTop
        Caption = 'Conferente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 63
      end
    end
    object gpPedido: TGroupBox
      Left = 8
      Top = 287
      Width = 300
      Height = 98
      Caption = 'Pedido'
      TabOrder = 2
      object lblSeparaPD: TDBText
        AlignWithMargins = True
        Left = 5
        Top = 33
        Width = 290
        Height = 17
        Margins.Top = 0
        Align = alTop
        Color = 16770261
        DataField = 'SEPARA_PD'
        DataSource = dtsInfo
        ParentColor = False
        ExplicitLeft = 7
        ExplicitTop = 28
        ExplicitWidth = 215
      end
      object lblSeparador: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 19
        Width = 290
        Height = 14
        Align = alTop
        Caption = 'Separador'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 57
      end
      object lblConferPD: TDBText
        AlignWithMargins = True
        Left = 5
        Top = 70
        Width = 290
        Height = 17
        Margins.Top = 0
        Align = alTop
        DataField = 'CONFER_PD'
        DataSource = dtsInfo
        ExplicitLeft = 24
        ExplicitTop = 81
        ExplicitWidth = 217
      end
      object lblConferente: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 56
        Width = 290
        Height = 14
        Align = alTop
        Caption = 'Conferente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 63
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 528
    Top = 8
  end
  object dtsInfo: TDataSource
    DataSet = cdsInfo
    Left = 528
    Top = 40
  end
  object cdsInfo: TUniClientDataSet
    Aggregates = <>
    DisableStringTrim = True
    Params = <>
    ProviderName = 'dspItens'
    Left = 560
    Top = 40
    object cdsInfoMEN001: TStringField
      FieldName = 'MEN001'
      Size = 80
    end
    object cdsInfoMEN002: TStringField
      FieldName = 'MEN002'
      Size = 80
    end
    object cdsInfoMENEXP: TStringField
      FieldName = 'MENEXP'
      Size = 70
    end
    object cdsInfoMENEX2: TStringField
      FieldName = 'MENEX2'
      Size = 70
    end
    object cdsInfoMENEX3: TStringField
      FieldName = 'MENEX3'
      Size = 70
    end
    object cdsInfoMENEX4: TStringField
      FieldName = 'MENEX4'
      Size = 70
    end
    object cdsInfoOBSEXP: TStringField
      FieldName = 'OBSEXP'
      Size = 50
    end
    object cdsInfoNOMTRA: TStringField
      FieldName = 'NOMTRA'
      Size = 50
    end
    object cdsInfoNUMREG: TStringField
      FieldName = 'NUMREG'
    end
    object cdsInfoCONFER: TStringField
      FieldName = 'CONFER'
      Size = 35
    end
    object cdsInfoSEPARA: TStringField
      FieldName = 'SEPARA'
      Size = 35
    end
    object cdsInfoNUMCMP: TStringField
      FieldName = 'NUMCMP'
      Size = 255
    end
    object cdsInfoCONFER_PD: TStringField
      FieldName = 'CONFER_PD'
      Size = 35
    end
    object cdsInfoSEPARA_PD: TStringField
      FieldName = 'SEPARA_PD'
      Size = 35
    end
    object cdsInfoREGCON: TStringField
      FieldName = 'REGCON'
      Size = 255
    end
  end
  object cdsRastroPed: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 519
    Top = 312
    object cdsRastroPedAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsRastroPedRTM_CODEMP: TStringField
      FieldName = 'RTM_CODEMP'
      Size = 3
    end
    object cdsRastroPedRTM_NUMDOC: TStringField
      FieldName = 'RTM_NUMDOC'
      Size = 12
    end
    object cdsRastroPedRTM_NUMFAT: TStringField
      FieldName = 'RTM_NUMFAT'
      Size = 12
    end
    object cdsRastroPedRTM_NUMREG: TStringField
      FieldName = 'RTM_NUMREG'
    end
    object cdsRastroPedRTM_TIPFAT: TStringField
      FieldName = 'RTM_TIPFAT'
      Size = 2
    end
    object cdsRastroPedRTM_EMPFAT: TStringField
      FieldName = 'RTM_EMPFAT'
      Size = 3
    end
  end
  object dtsRastroPed: TDataSource
    AutoEdit = False
    DataSet = cdsRastroPed
    Left = 551
    Top = 312
  end
end
