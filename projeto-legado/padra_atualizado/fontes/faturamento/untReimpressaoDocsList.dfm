inherited frmReimpressaoDocsList: TfrmReimpressaoDocsList
  Left = 142
  Top = 112
  Width = 1076
  Height = 600
  Caption = 'Relat'#243'rio de Reimpress'#227'o de Documentos'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1076
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 512
    Width = 1070
    Height = 43
    ExplicitTop = 512
    ExplicitWidth = 1070
    ExplicitHeight = 43
    object lblBusca: TLabel [0]
      Left = 7
      Top = 6
      Width = 55
      Height = 14
      Caption = 'F3 - Busca'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDocConf: TLabel [1]
      Left = 78
      Top = 6
      Width = 153
      Height = 14
      Caption = 'F4 - Documentos de Origem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel [2]
      Left = 249
      Top = 6
      Width = 91
      Height = 14
      Caption = 'F9 - Enviar E-mail'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel [3]
      Left = 347
      Top = 6
      Width = 148
      Height = 14
      Caption = 'F10 - Visualizar Documento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblOpeNfe: TLabel [4]
      Left = 506
      Top = 6
      Width = 155
      Height = 14
      Caption = '[BTN. Direito] Opera'#231#245'es Nfe'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblVolPed: TLabel [5]
      Left = 669
      Top = 6
      Width = 129
      Height = 14
      Caption = 'F7 - Volumes do pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblVendedores: TLabel [6]
      Left = 812
      Top = 6
      Width = 148
      Height = 14
      Caption = 'F8 - Vendedores do pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblDocDev: TLabel [7]
      Left = 7
      Top = 21
      Width = 155
      Height = 14
      Caption = 'F6 - Documentos Devolvidos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDocFat: TLabel [8]
      Left = 173
      Top = 21
      Width = 155
      Height = 14
      Caption = 'F11 - Documentos Faturados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblEnvWpp: TLabel [9]
      Left = 345
      Top = 21
      Width = 112
      Height = 14
      Caption = 'F5 - Enviar Whatsapp'
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
      Enabled = False
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    inherited btnSair: TBitBtnLocked
      Left = 980
      Top = 10
      ExplicitLeft = 980
      ExplicitTop = 10
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 1070
    ExplicitTop = 555
    ExplicitWidth = 1070
    inherited pnlNomeForm: TPanel
      Left = 874
      Width = 196
      ExplicitLeft = 874
      ExplicitWidth = 196
    end
    inherited pnlInfo: TPanel
      Width = 874
      ExplicitWidth = 874
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 1070
    Height = 512
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblSelecione: TLabel
      Left = 2
      Top = 2
      Width = 1066
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 'Selecione o documento desejado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 184
    end
    object dbgDocumentos: TDBGridCitel
      Left = 2
      Top = 16
      Width = 1066
      Height = 494
      Align = alClient
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      PopupMenu = mnuOperacoesNfe
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnCellClick = dbgDocumentosCellClick
      OnDblClick = dbgDocumentosDblClick
      OnKeyDown = dbgDocumentosKeyDown
      OnMouseMove = dbgDocumentosMouseMove
      OnMouseUp = dbgDocumentosMouseUp
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'DOCCAN'
          Title.Caption = ' '
          Width = 13
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DTAENT'
          Title.Caption = 'Data'
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMDOC'
          Title.Caption = 'Documento'
          Width = 111
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SERIE_'
          Title.Caption = 'S'#233'rie'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SITUACAO'
          Title.Caption = 'Situa'#231#227'o'
          Width = 225
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESPDOC'
          Title.Caption = 'ESP'
          Width = 25
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODEMP'
          Title.Caption = 'EMP'
          Width = 24
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLAFIS'
          Title.Caption = 'CFOP'
          Width = 39
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DOCORI'
          Title.Caption = 'Doc. Origem'
          Width = 138
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMFAT'
          Title.Caption = 'Doc. Conf.'
          Width = 128
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODVEN'
          Title.Caption = 'VEN'
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMCLI'
          Title.Caption = 'Cliente'
          Width = 269
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'VLRCON'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor'
          Width = 72
          Visible = True
        end>
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 488
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 520
    Top = 216
  end
  object mnuOperacoesNfe: TPopupMenu
    OnPopup = mnuOperacoesNfePopup
    Left = 552
    Top = 216
    object mnuReimprimirDanfe: TMenuItem
      Caption = 'Reimprimir Danfe'
      OnClick = mnuReimprimirDanfeClick
    end
    object mnuNotaSubstituicaoNFSe: TMenuItem
      Caption = 'Enviar nota de Substitui'#231#227'o (NFSe)'
      Visible = False
      OnClick = mnuNotaSubstituicaoNFSeClick
    end
    object mnuGerarDanfePDF: TMenuItem
      Caption = 'Gerar Danfe em PDF'
      OnClick = mnuGerarDanfePDFClick
    end
    object mnuReimprimirTermoAceiteCV: TMenuItem
      Caption = 'Reimprimir Termo de Aceite de Compra e Venda'
      Visible = False
      OnClick = mnuReimprimirTermoAceiteCVClick
    end
    object mnuTermoTinta: TMenuItem
      Caption = 'Reimprimir Termo de Venda de Tinta de M'#225'quina'
      OnClick = mnuTermoTintaClick
    end
    object mnuEndEntr: TMenuItem
      Caption = 'Reimprimir Endere'#231'o de Entrega'
      OnClick = mnuEndEntrClick
    end
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaHide
    HintStyle.AnimationDelay = 1000
    HintStyle.CallOutPosition = cxbpTopLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Arial'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -12
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintHidePause = 1000
    Left = 616
    Top = 66
  end
end
