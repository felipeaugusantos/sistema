inherited frmFatRomConferenciaVolumes: TfrmFatRomConferenciaVolumes
  Width = 380
  Height = 345
  Caption = 'Confer'#234'ncia de volumes por c'#243'digo de barras'
  Position = poOwnerFormCenter
  ExplicitWidth = 380
  ExplicitHeight = 345
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 272
    Width = 374
    ExplicitTop = 272
    ExplicitWidth = 374
    inherited FlwBotoes: TFlowPanel
      Width = 370
      TabOrder = 2
      ExplicitWidth = 370
    end
    inherited btnSair: TBitBtnLocked
      Left = 291
      ExplicitLeft = 291
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 80
      Height = 22
      Caption = '[F10] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnConfeVolAut: TBitBtnLocked
      Left = 86
      Top = 3
      Width = 147
      Height = 22
      Caption = '[F5] Confer'#234'ncia Autom'#225'tica'
      TabOrder = 3
      OnClick = btnConfeVolAutClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 300
    Width = 374
    ExplicitTop = 300
    ExplicitWidth = 374
    inherited pnlNomeForm: TPanel
      Left = 203
      ExplicitLeft = 203
    end
    inherited pnlInfo: TPanel
      Width = 203
      ExplicitWidth = 203
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 374
    Height = 73
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 84
      Height = 14
      Caption = 'C'#243'digo de Barras'
    end
    object edtCodBar: TEditFocus
      Tag = 99
      Left = 8
      Top = 28
      Width = 305
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 20
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 20
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgVolumes: TDBGridCitel [3]
    Left = 0
    Top = 73
    Width = 374
    Height = 199
    Align = alClient
    DataSource = dtsVolumes
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
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
        FieldName = 'NUMDOC'
        Title.Caption = 'Documento'
        Width = 106
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESPDOC'
        Title.Caption = 'Esp'#233'cie'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODEMP'
        Title.Caption = 'Empresa'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMVOL'
        Title.Caption = 'Nro. Volume'
        Visible = True
      end>
  end
  object cdsVolumes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 304
    Top = 16
    object cdsVolumesNUMDOC: TStringField
      DisplayWidth = 12
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsVolumesESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsVolumesCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsVolumesNUMVOL: TIntegerField
      FieldName = 'NUMVOL'
    end
  end
  object dtsVolumes: TDataSource
    DataSet = cdsVolumes
    Left = 336
    Top = 16
  end
end
