inherited frmFatConfNotaConcreto: TfrmFatConfNotaConcreto
  Left = 172
  Top = 140
  Width = 800
  Height = 557
  BorderIcons = [biSystemMenu]
  Caption = 'Confirma'#231#227'o de Notas Fiscais - Concreto'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 481
    Width = 794
    TabOrder = 4
    ExplicitTop = 481
    ExplicitWidth = 794
    DesignSize = (
      794
      0)
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pgcDados: TPageControl
    Left = 569
    Top = 87
    Width = 225
    Height = 394
    TabOrder = 2
    Visible = False
    ExplicitLeft = 569
    ExplicitTop = 87
    ExplicitWidth = 225
    ExplicitHeight = 394
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 217
      ExplicitHeight = 362
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 87
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 35
      Top = 15
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object lblDtaIni: TLabel
      Left = 16
      Top = 61
      Width = 54
      Height = 14
      Caption = 'Data Inicial:'
    end
    object lblDtaFin: TLabel
      Left = 155
      Top = 61
      Width = 50
      Height = 14
      Caption = 'Data Final:'
    end
    object lblCliFat: TLabel
      Left = 7
      Top = 38
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Novo Cliente:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 74
      Top = 11
      Width = 72
      Height = 22
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
      Left = 148
      Top = 11
      Width = 601
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 74
      Top = 57
      Width = 71
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 210
      Top = 57
      Width = 71
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCliFat: TEditFocus
      Tag = 99
      Left = 74
      Top = 34
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 1
      OnKeyPress = edtCliFatKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCliFat: TEditFocus
      Left = 148
      Top = 34
      Width = 601
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  end
  object pnlAux2: TPanel [4]
    Left = 0
    Top = 87
    Width = 569
    Height = 394
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object dbgDocumentos: TDBGridCitel
      Left = 0
      Top = 0
      Width = 569
      Height = 394
      Align = alClient
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
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
          FieldName = 'TMP_NUM_PD'
          Title.Caption = 'Pedido'
          Width = 79
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_ESP_PD'
          Title.Caption = 'Esp.'
          Width = 26
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_EMP_PD'
          Title.Caption = 'Emp.'
          Width = 30
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_NUMDOC'
          Title.Caption = 'Documento'
          Width = 83
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_ESPDOC'
          Title.Caption = 'Esp.'
          Width = 24
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_CODEMP'
          Title.Caption = 'Emp.'
          Width = 29
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_DTAENT'
          Title.Caption = 'Dta. Emiss'#227'o'
          Width = 68
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_CODVEN'
          Title.Caption = 'Vendedor'
          Width = 55
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TMP_VLRCON'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. Total'
          Width = 75
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TMP_ITEDOC'
          Title.Alignment = taRightJustify
          Title.Caption = 'Itens'
          Width = 54
          Visible = True
        end>
    end
  end
  object pnlAux1: TPanel [5]
    Left = 569
    Top = 87
    Width = 225
    Height = 394
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 6
    object pnlDadosDup: TPanel
      Left = 0
      Top = 0
      Width = 225
      Height = 176
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label4: TLabel
        Left = 2
        Top = 2
        Width = 221
        Height = 23
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'TOTAIS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 3
        ExplicitWidth = 250
      end
      object Label3: TLabel
        Left = 22
        Top = 51
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Documento(s):'
      end
      object Label7: TLabel
        Left = 63
        Top = 74
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object edtQtdDoc: TEditFocus
        Left = 119
        Top = 47
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
      object edtTotGer: TEditFocus
        Left = 119
        Top = 70
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
    end
    object pnlInformativos: TPanel
      Left = 0
      Top = 176
      Width = 225
      Height = 218
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label16: TLabel
        Left = 2
        Top = 2
        Width = 221
        Height = 31
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'SELECIONADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 248
      end
      object Label6: TLabel
        Left = 22
        Top = 54
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Documento(s):'
      end
      object Label12: TLabel
        Left = 63
        Top = 77
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object edtQtdDocSel: TEditFocus
        Left = 119
        Top = 50
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
      object edtTotGerSel: TEditFocus
        Left = 119
        Top = 73
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
    end
  end
  object pnlBotoesBaixa: TPanel [6]
    Left = 0
    Top = 481
    Width = 794
    Height = 31
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object btnItensDoc: TBitBtnLocked
      Left = 4
      Top = 5
      Width = 137
      Height = 22
      Caption = '[ F5 ] Itens do Documento'
      TabOrder = 0
      OnClick = btnItensDocClick
    end
    object btnSairConf: TBitBtnLocked
      Left = 673
      Top = 5
      Width = 111
      Height = 22
      Caption = '[ Esc ] Sair'
      TabOrder = 2
      OnClick = btnSairConfClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 143
      Top = 5
      Width = 129
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 512
    Width = 794
    TabOrder = 3
    ExplicitTop = 512
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 609
      Width = 185
      ExplicitLeft = 609
      ExplicitWidth = 185
    end
    inherited pnlInfo: TPanel
      Width = 609
      ExplicitWidth = 609
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 232
    Top = 272
  end
end
