inherited frmFatCancelarBaixaDocumentos: TfrmFatCancelarBaixaDocumentos
  Left = 0
  Top = 0
  Width = 650
  Height = 462
  BorderIcons = [biSystemMenu]
  Caption = 'Cancelar Baixa de Documentos'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  Position = poMainFormCenter
  ExplicitWidth = 650
  ExplicitHeight = 462
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 377
    Width = 644
    ExplicitTop = 495
    ExplicitWidth = 790
    inherited FlwBotoes: TFlowPanel
      Width = 640
      ExplicitTop = 2
      ExplicitWidth = 786
    end
  end
  inherited pgcDados: TPageControl
    Top = 65
    Width = 644
    Height = 312
    ActivePage = nil
    ExplicitTop = 65
    ExplicitWidth = 790
    ExplicitHeight = 430
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitTop = 6
      ExplicitWidth = 782
      ExplicitHeight = 420
    end
  end
  inherited pnlStatus: TPanel
    Top = 416
    Width = 644
    Height = 17
    ExplicitTop = 416
    ExplicitWidth = 644
    ExplicitHeight = 17
    inherited pnlNomeForm: TPanel
      Left = 473
      Height = 17
      ExplicitLeft = 465
      ExplicitTop = 6
      ExplicitHeight = 18
    end
    inherited pnlInfo: TPanel
      Width = 473
      Height = 17
      Align = alLeft
      ExplicitWidth = 473
      ExplicitHeight = 31
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 644
    Height = 65
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitWidth = 790
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label15: TLabel
      Left = 5
      Top = 36
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label20: TLabel
      Left = 129
      Top = 36
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #225
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 49
      Top = 9
      Width = 80
      Height = 21
      Alignment = taLeftJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 131
      Top = 9
      Width = 494
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 49
      Top = 32
      Width = 72
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 141
      Top = 32
      Width = 72
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object dbgDocumentos: TDBGridCitel [5]
    Left = 0
    Top = 65
    Width = 644
    Height = 312
    Align = alClient
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgDocumentosDrawColumnCell
    OnDblClick = dbgDocumentosDblClick
    OnKeyDown = dbgDocumentosKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TMP_DTAENT'
        Title.Caption = 'Dta. Emiss'#227'o'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TMP_CONPAG'
        Title.Caption = 'Cnd. Pgto.'
        Width = 83
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TMP_CODVEN'
        Title.Alignment = taCenter
        Title.Caption = 'Ven.'
        Width = 26
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TMP_NUMDOC'
        Title.Alignment = taCenter
        Title.Caption = 'Documento'
        Width = 113
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TMP_ESPDOC'
        Title.Alignment = taCenter
        Title.Caption = 'Esp.'
        Width = 26
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TMP_CODEMP'
        Title.Alignment = taCenter
        Title.Caption = 'Emp.'
        Width = 26
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TMP_ENTRET'
        Title.Alignment = taCenter
        Title.Caption = 'Ent/Ret'
        Width = 38
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TMP_CLAFIS'
        Title.Alignment = taCenter
        Title.Caption = 'CFOP'
        Width = 30
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TMP_VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vlr. Total'
        Width = 70
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TMP_DUPREC'
        Title.Alignment = taRightJustify
        Title.Caption = 'Dup. Pagas'
        Width = 70
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TMP_ITEDOC'
        Title.Alignment = taRightJustify
        Title.Caption = 'Itens'
        Width = 29
        Visible = True
      end>
  end
  object FlowPanel1: TFlowPanel [6]
    Left = 0
    Top = 392
    Width = 644
    Height = 24
    Align = alBottom
    TabOrder = 6
    ExplicitTop = 510
    ExplicitWidth = 790
    object btnMarca: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 110
      Height = 22
      Caption = '[ F7 ] Marca Tudo'
      TabOrder = 0
      OnClick = btnMarcaClick
    end
    object btnDesmarca: TBitBtnLocked
      Tag = 1
      Left = 111
      Top = 1
      Width = 110
      Height = 22
      Caption = '[ F8 ] Desmarca Tudo'
      TabOrder = 1
      OnClick = btnDesmarcaClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 221
      Top = 1
      Width = 130
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 2
      OnClick = btnConfirmaClick
    end
    object btnSairConf: TBitBtnLocked
      Left = 351
      Top = 1
      Width = 81
      Height = 22
      Caption = '[ Esc ] Sair'
      TabOrder = 3
      OnClick = btnSairConfClick
    end
  end
  object prbProgresso: TProgressBar [7]
    Left = 0
    Top = 377
    Width = 644
    Height = 15
    Align = alBottom
    TabOrder = 7
    Visible = False
    ExplicitTop = 495
    ExplicitWidth = 790
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 224
    Top = 16
  end
end
