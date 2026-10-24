inherited frmRcxConfCupom: TfrmRcxConfCupom
  Left = 155
  Top = 170
  Width = 771
  BorderIcons = [biSystemMenu]
  Caption = 'Confirma'#231#227'o de Cupom Fiscal'
  Position = poMainFormCenter
  ExplicitWidth = 771
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 375
    Width = 765
    ExplicitTop = 375
    ExplicitWidth = 765
    inherited FlwBotoes: TFlowPanel
      Width = 761
      ExplicitTop = 2
      ExplicitWidth = 761
    end
  end
  inherited pgcDados: TPageControl
    Top = 32
    Width = 765
    Height = 343
    ExplicitTop = 32
    ExplicitWidth = 765
    ExplicitHeight = 343
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 757
      ExplicitHeight = 311
      object Panel1: TPanel
        Left = 0
        Top = 311
        Width = 757
        Height = 0
        Align = alBottom
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Color = clGray
        Enabled = False
        ParentBackground = False
        TabOrder = 0
        Visible = False
        DesignSize = (
          757
          0)
        object BitBtn1: TBitBtnLocked
          Left = 619
          Top = -25
          Width = 77
          Height = 22
          Anchors = [akRight, akBottom]
          Caption = '&Sair'
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000120B0000120B0000000100000001000000520000006B
            0000006B0800106B0800008C080000940800007B100000731800087B180008A5
            1800089C21001094290010A529001084310010A5310018A5310010A539001884
            4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
            4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
            5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
            AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
            BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
            CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
            D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
            DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
            F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
            FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
            FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
            5959595959595959595932514E32323232325959595959595959325266655F5F
            5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
            1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
            21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
            44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
            372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
            4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
            6A4A231B59595959595959592626262626262359595959595959}
          TabOrder = 0
          OnClick = btnSairClick
        end
      end
    end
  end
  object pnlTitulo: TPanel [3]
    Left = 0
    Top = 0
    Width = 765
    Height = 32
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'DOCUMENTOS PARA EMISS'#195'O DE CUPOM FISCAL'
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
  end
  object dbgDocumentos: TDBGridCitel [4]
    Left = 0
    Top = 32
    Width = 765
    Height = 343
    Align = alClient
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnCellClick = dbgDocumentosCellClick
    OnDrawColumnCell = dbgDocumentosDrawColumnCell
    OnDblClick = dbgDocumentosDblClick
    OnKeyDown = dbgDocumentosKeyDown
    OnKeyUp = dbgDocumentosKeyUp
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'GER_DTAENT'
        Title.Alignment = taCenter
        Title.Caption = 'Data'
        Width = 70
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'GER_HORENT'
        Title.Alignment = taCenter
        Title.Caption = 'Hora'
        Width = 70
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'GER_DOCESP'
        Title.Alignment = taCenter
        Title.Caption = 'Documento'
        Width = 161
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 286
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'GER_VLRCON'
        Title.Alignment = taCenter
        Title.Caption = 'Valor'
        Width = 121
        Visible = True
      end>
  end
  object pnlDadosInformativos: TPanel [5]
    Left = 0
    Top = 375
    Width = 765
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object Label21: TLabel
      Left = 550
      Top = 11
      Width = 109
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total dos Documentos:'
    end
    object Label1: TLabel
      Left = 9
      Top = 11
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object edtTotGer: TEditFocus
      Left = 663
      Top = 7
      Width = 90
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtNomVen: TEditFocus
      Left = 101
      Top = 7
      Width = 319
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodVen: TEditFocus
      Left = 61
      Top = 7
      Width = 39
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  end
  object pnlBotoesSelecao: TPanel [6]
    Left = 0
    Top = 411
    Width = 765
    Height = 49
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object FlwPnlBotoesSelecao: TFlowPanel
      Left = 2
      Top = 2
      Width = 761
      Height = 45
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      ExplicitWidth = 271
      object btnEmiteCupom: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ ENTER ] Emite Cupom'
        TabOrder = 0
        OnClick = btnEmiteCupomClick
      end
      object btnIniciaBusca: TBitBtnLocked
        Left = 150
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F5 ] Inicia Busca'
        TabOrder = 1
        OnClick = btnIniciaBuscaClick
      end
      object btnLocProxima: TBitBtnLocked
        Left = 300
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F6 ] Localiza Pr'#243'xima'
        TabOrder = 2
        OnClick = btnLocProximaClick
      end
      object btnAbreGaveta: TBitBtnLocked
        Left = 450
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F7 ] Abre Gaveta'
        TabOrder = 3
        OnClick = btnAbreGavetaClick
      end
      object btnMarcaImpresso: TBitBtnLocked
        Left = 600
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F9 ] Marca como Impresso'
        TabOrder = 4
        Visible = False
        OnClick = btnMarcaImpressoClick
      end
      object btnImprimirCuponsDiasAnteriores: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 300
        Height = 22
        Caption = '[ F12 ] Imprimir Cupons de dias anteriores'
        TabOrder = 5
        OnClick = btnImprimirCuponsDiasAnterioresClick
      end
      object Shape1: TShape
        AlignWithMargins = True
        Left = 303
        Top = 25
        Width = 26
        Height = 18
        Brush.Color = clMoneyGreen
        Pen.Style = psClear
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 335
        Top = 27
        Width = 268
        Height = 12
        Margins.Top = 5
        Caption = 'Cupons de datas anteriores que n'#227'o foram impressos no ECF'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
    object btnSairSelecao: TBitBtnLocked
      Left = 602
      Top = 25
      Width = 150
      Height = 22
      Caption = '[ ESC ] Sair'
      TabOrder = 1
      OnClick = btnSairSelecaoClick
    end
  end
  inherited pnlStatus: TPanel
    Width = 765
    ExplicitWidth = 765
    inherited pnlNomeForm: TPanel
      Left = 594
      ExplicitLeft = 594
    end
    inherited pnlInfo: TPanel
      Width = 594
      ExplicitWidth = 594
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 72
  end
  object PopupMenu1: TPopupMenu
    Left = 320
    Top = 80
    object MenuItem1: TMenuItem
      Caption = 'Configurar Relat'#243'rio'
      OnClick = mnuConfigurarRelClick
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 320
    Top = 80
    object MenuItem2: TMenuItem
      Caption = 'Configurar Relat'#243'rio'
      OnClick = mnuConfigurarRelClick
    end
  end
end
