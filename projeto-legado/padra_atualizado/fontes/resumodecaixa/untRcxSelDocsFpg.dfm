inherited frmRcxSelDocsFpg: TfrmRcxSelDocsFpg
  Left = 228
  Top = 226
  Width = 853
  Height = 337
  BorderIcons = [biSystemMenu]
  Caption = 'Documentos para altera'#231#227'o de Forma de Pagamento'
  Position = poMainFormCenter
  ExplicitWidth = 853
  ExplicitHeight = 337
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 264
    Width = 847
    ExplicitTop = 264
    ExplicitWidth = 847
    object lblCliente: TLabel [0]
      Left = 8
      Top = 6
      Width = 42
      Height = 14
      Caption = 'Cliente:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 0
      Height = 0
      Align = alNone
      ExplicitTop = 2
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    inherited btnSair: TBitBtnLocked
      Left = 764
      TabOrder = 2
      ExplicitLeft = 764
    end
    object dbeCliente: TDBEditFocus
      Left = 56
      Top = 3
      Width = 369
      Height = 22
      Color = 16768952
      DataField = 'CLI_NOMCLI'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgDocumentos: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 847
    Height = 264
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgDocumentosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'RCX_NUMDOC'
        Title.Caption = 'Documento'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RCX_ESPDOC'
        Title.Caption = 'Esp.'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RCX_CODEMP'
        Title.Caption = 'Emp.'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RCX_SEQCON'
        Title.Caption = 'Seq.Baixa'
        Width = 52
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'RCX_DINREC'
        Title.Alignment = taRightJustify
        Title.Caption = 'Dinheiro'
        Width = 73
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'RCX_CARREC'
        Title.Alignment = taRightJustify
        Title.Caption = 'Cart'#227'o'
        Width = 77
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'RCX_CHQAVI'
        Title.Alignment = taRightJustify
        Title.Caption = 'Cheque'
        Width = 67
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'RCX_CHQPRE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Cheque Pr'#233
        Width = 75
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'RCX_ORDREC'
        Title.Alignment = taRightJustify
        Title.Caption = 'Ord.Pag.'
        Width = 69
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'RCX_VENPRZ'
        Title.Alignment = taRightJustify
        Title.Caption = 'Faturado'
        Width = 67
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'RCX_VALFIN'
        Title.Alignment = taRightJustify
        Title.Caption = 'Financ.'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'RCX_VALGRD'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total'
        Width = 70
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 292
    Width = 847
    ExplicitTop = 292
    ExplicitWidth = 847
    inherited pnlNomeForm: TPanel
      Left = 676
      ExplicitLeft = 676
    end
    inherited pnlInfo: TPanel
      Width = 676
      ExplicitWidth = 676
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 56
  end
end
