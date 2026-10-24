inherited frmFatManConsertoAlteraTecnico: TfrmFatManConsertoAlteraTecnico
  Width = 633
  Height = 342
  Caption = 'Altera'#231#227'o de T'#233'cnico na Ordem de Servi'#231'o'
  OnDestroy = FormDestroy
  ExplicitWidth = 633
  ExplicitHeight = 342
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 271
    Width = 627
    TabOrder = 3
    ExplicitTop = 271
    ExplicitWidth = 627
    inherited FlwBotoes: TFlowPanel
      Width = 623
      ExplicitWidth = 623
    end
    inherited btnSair: TBitBtnLocked
      Left = 544
      ExplicitLeft = 544
    end
  end
  inherited pnlStatus: TPanel
    Top = 297
    Width = 627
    TabOrder = 4
    ExplicitTop = 297
    ExplicitWidth = 627
    inherited pnlNomeForm: TPanel
      Left = 456
      ExplicitLeft = 456
    end
    inherited pnlInfo: TPanel
      Width = 456
      ExplicitWidth = 456
    end
  end
  object dbgServico: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 627
    Height = 216
    Align = alClient
    DataSource = dtsSerEqu
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgServicoDrawColumnCell
    OnDblClick = dbgServicoDblClick
    OnKeyPress = dbgServicoKeyPress
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'DESSER'
        Title.Caption = 'Descri'#231#227'o'
        Width = 590
        Visible = True
      end>
  end
  object pnlTecnico: TPanel [3]
    Left = 0
    Top = 216
    Width = 627
    Height = 37
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      627
      37)
    object Label11: TLabel
      Left = 8
      Top = 9
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Novo T'#233'cnico:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtNomTec: TEditFocus
      Left = 128
      Top = 6
      Width = 482
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtCodTec: TEditFocus
      Tag = 99
      Left = 82
      Top = 6
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtCodTecKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlBottom: TPanel [4]
    Left = 0
    Top = 253
    Width = 627
    Height = 18
    Align = alBottom
    Caption = '[ENTER] ou Duplo Clique -  Marca / Desmarca Servi'#231'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 216
    Top = 136
  end
  object dtsSerEqu: TDataSource
    Left = 384
    Top = 136
  end
end
