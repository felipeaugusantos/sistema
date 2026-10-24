inherited frmReqEnvioMatVidroSelDoc: TfrmReqEnvioMatVidroSelDoc
  Left = 146
  Top = 123
  Width = 790
  Height = 550
  Caption = 'Requisi'#231#227'o de Envio de Materiais - Vidro - Documentos'
  ExplicitWidth = 790
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 467
    Width = 774
    TabOrder = 6
    ExplicitTop = 467
    ExplicitWidth = 774
    inherited FlwBotoes: TFlowPanel
      Width = 693
      Align = alClient
      ExplicitTop = 2
      ExplicitWidth = 770
      inherited btnMudaOrdem: TBitBtnLocked
        Height = 24
        Align = alLeft
        ExplicitHeight = 24
      end
      inherited btnPesquisar: TBitBtnLocked
        Width = 105
        Height = 24
        Align = alLeft
        ExplicitWidth = 105
        ExplicitHeight = 24
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 695
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 695
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlHeader: TPanel
    Width = 774
    Height = 33
    TabOrder = 0
    Visible = False
    ExplicitWidth = 774
    ExplicitHeight = 33
  end
  inherited pnlTail: TPanel
    Top = 448
    Width = 774
    Height = 19
    Caption = 'PRESSIONE [ENTER] SOBRE UM DOCUMENTO PARA SELECIONAR O MESMO'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    Visible = True
    ExplicitTop = 448
    ExplicitWidth = 774
    ExplicitHeight = 19
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 73
    Width = 774
    Height = 279
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DTAORC'
        Title.Alignment = taCenter
        Title.Caption = 'Data Or'#231'am.'
        Width = 73
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NUMORC'
        Title.Alignment = taCenter
        Title.Caption = 'Or'#231'amento'
        Width = 129
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALORC'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Or'#231'am.'
        Width = 84
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DTAFAT'
        Title.Alignment = taCenter
        Title.Caption = 'Data Faturam.'
        Width = 75
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DOCFAT'
        Title.Alignment = taCenter
        Title.Caption = 'Documento'
        Width = 134
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALFAT'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Docum.'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLIFAT'
        Title.Caption = 'Cliente'
        Width = 152
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 33
    Width = 774
    TabOrder = 1
    ExplicitTop = 33
    ExplicitWidth = 774
  end
  inherited pnlStatus: TPanel
    Top = 495
    Width = 774
    TabOrder = 7
    ExplicitTop = 495
    ExplicitWidth = 774
    inherited pnlNomeForm: TPanel
      Left = 603
      ExplicitLeft = 603
    end
    inherited pnlInfo: TPanel
      Width = 603
      ExplicitWidth = 603
    end
  end
  object pnlMenExp: TPanel [7]
    Left = 0
    Top = 352
    Width = 774
    Height = 36
    Align = alBottom
    ParentBackground = False
    ParentColor = True
    TabOrder = 3
    object dbtxtMENEXP2: TDBText
      Left = 95
      Top = 17
      Width = 636
      Height = 17
      DataField = 'MEN002'
      DataSource = dtsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 22
      Top = 3
      Width = 72
      Height = 17
      Alignment = taRightJustify
      Caption = 'Men.Ped:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbtxtMENEXP: TDBText
      Left = 95
      Top = 4
      Width = 636
      Height = 17
      DataField = 'MEN001'
      DataSource = dtsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel1: TPanel [8]
    Left = 0
    Top = 388
    Width = 774
    Height = 60
    Align = alBottom
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
    object DBText1: TDBText
      Left = 95
      Top = 15
      Width = 636
      Height = 17
      DataField = 'MENEX2'
      DataSource = dtsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 95
      Top = 28
      Width = 636
      Height = 17
      DataField = 'MENEX3'
      DataSource = dtsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object DBText3: TDBText
      Left = 95
      Top = 41
      Width = 636
      Height = 17
      DataField = 'MENEX4'
      DataSource = dtsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 22
      Top = 1
      Width = 72
      Height = 17
      Alignment = taRightJustify
      Caption = 'Men.Exp:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText4: TDBText
      Left = 95
      Top = 2
      Width = 636
      Height = 17
      DataField = 'MENEXP'
      DataSource = dtsConsulta
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 328
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 416
    Top = 328
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
    Top = 328
  end
  inherited qryConsulta: TUniQuery
    Left = 272
    Top = 328
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 304
    Top = 328
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 336
    Top = 328
  end
  inherited dtsConsulta: TDataSource
    Left = 368
    Top = 328
  end
end
