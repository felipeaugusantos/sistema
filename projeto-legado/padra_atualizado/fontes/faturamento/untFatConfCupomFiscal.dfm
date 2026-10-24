inherited frmFatConfCupomFiscal: TfrmFatConfCupomFiscal
  Left = 172
  Top = 140
  Width = 800
  Height = 557
  BorderIcons = [biSystemMenu]
  Caption = 'Confirma'#231#227'o de Cupom Fiscal'
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
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitWidth = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
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
  inherited pgcDados: TPageControl
    Left = 569
    Top = 87
    Width = 225
    Height = 394
    TabOrder = 2
    Visible = False
    ExplicitLeft = 540
    ExplicitTop = 87
    ExplicitWidth = 254
    ExplicitHeight = 394
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 246
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
    object Label2: TLabel
      Left = 16
      Top = 61
      Width = 54
      Height = 14
      Caption = 'Data Inicial:'
    end
    object Label5: TLabel
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
    object chkCupEsp: TCheckBox
      Tag = 99
      Left = 296
      Top = 59
      Width = 217
      Height = 17
      Caption = 'Incluir Cupom Especial'
      TabOrder = 6
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
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
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
          FieldName = 'TMP_DTAENT'
          Title.Caption = 'Dta. Emiss'#227'o'
          Width = 75
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_CODVEN'
          Title.Alignment = taCenter
          Title.Caption = 'Vendedor'
          Width = 70
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_NUMDOC'
          Title.Alignment = taCenter
          Title.Caption = 'Documento'
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_SERDOC'
          Title.Alignment = taCenter
          Title.Caption = 'Serie'
          Width = 47
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
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TMP_VLRCON'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. Total'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TMP_DUPREC'
          Title.Alignment = taRightJustify
          Title.Caption = 'Dup. Pagas'
          Width = 80
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
    ExplicitLeft = 540
    ExplicitWidth = 254
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
      ExplicitWidth = 254
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
        ExplicitWidth = 248
      end
      object Label3: TLabel
        Left = 17
        Top = 51
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Documento(s):'
      end
      object Label7: TLabel
        Left = 58
        Top = 74
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object Label9: TLabel
        Left = 25
        Top = 97
        Width = 86
        Height = 14
        Alignment = taRightJustify
        Caption = 'Duplicatas Pagas:'
      end
      object Label11: TLabel
        Left = 49
        Top = 120
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total L'#237'quido:'
      end
      object edtQtdDoc: TEditFocus
        Left = 114
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
        Left = 114
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
      object edtDupPag: TEditFocus
        Left = 114
        Top = 93
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
      object edtTotLiq: TEditFocus
        Left = 114
        Top = 116
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
    end
    object pnlInformativos: TPanel
      Left = 0
      Top = 176
      Width = 225
      Height = 158
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      ExplicitWidth = 254
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
        Left = 17
        Top = 54
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Documento(s):'
      end
      object Label12: TLabel
        Left = 58
        Top = 77
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object Label14: TLabel
        Left = 25
        Top = 100
        Width = 86
        Height = 14
        Alignment = taRightJustify
        Caption = 'Duplicatas Pagas:'
      end
      object Label17: TLabel
        Left = 49
        Top = 123
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total L'#237'quido:'
      end
      object edtQtdDocSel: TEditFocus
        Left = 114
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
        Left = 114
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
      object edtDupPagSel: TEditFocus
        Left = 114
        Top = 96
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
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
      object edtTotLiqSel: TEditFocus
        Left = 114
        Top = 119
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
    end
    object pnlLegendas: TPanel
      Left = 0
      Top = 334
      Width = 225
      Height = 60
      Align = alBottom
      ParentBackground = False
      ParentColor = True
      TabOrder = 2
      ExplicitWidth = 254
      object Shape1: TShape
        Left = 8
        Top = 8
        Width = 14
        Height = 14
      end
      object Label8: TLabel
        Left = 27
        Top = 8
        Width = 64
        Height = 14
        Caption = 'Cupom Fiscal'
      end
      object Shape2: TShape
        Left = 8
        Top = 24
        Width = 14
        Height = 14
        Brush.Color = clMoneyGreen
      end
      object Label10: TLabel
        Left = 27
        Top = 24
        Width = 107
        Height = 14
        Caption = 'Cupom Fiscal Especial'
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
      TabOrder = 7
      OnClick = btnSairConfClick
    end
    object btnGeraFF: TBitBtnLocked
      Left = 538
      Top = 5
      Width = 129
      Height = 22
      Caption = '[ F6 ] Gera FF'
      TabOrder = 6
      OnClick = btnGeraFFClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 408
      Top = 5
      Width = 129
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 5
      OnClick = btnConfirmaClick
    end
    object btnMarca: TBitBtnLocked
      Left = 143
      Top = 5
      Width = 110
      Height = 22
      Caption = '[ F7 ] Marca Tudo'
      TabOrder = 1
      OnClick = btnMarcaClick
    end
    object btnPopMenuMarca: TBitBtnLocked
      Left = 252
      Top = 5
      Width = 22
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Enabled = False
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000C40E0000C40E00000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000001E1E1E1E1E1E0000000000000000000000
        00000000000000000000000000000000000000000000000000000000000000C3
        C3C3EBEBEB000000000000000000000000000000000000000000000000000000
        0000000000000000000000001E1E1E3C3C3C3C3C3C1E1E1E0000000000000000
        00000000000000000000000000000000000000000000000000000000C3C3C3EB
        EBEBEBEBEBEBEBEB000000000000000000000000000000000000000000000000
        0000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000000000
        00000000000000000000000000000000000000000000000000C3C3C3EBEBEBEB
        EBEBEBEBEBEBEBEBEBEBEB000000000000000000000000000000000000000000
        0000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000
        00000000000000000000000000000000000000000000C3C3C3EBEBEBEBEBEBEB
        EBEBEBEBEBEBEBEBEBEBEBEBEBEB000000000000000000000000000000000000
        0000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E
        1E000000000000000000000000000000000000C3C3C3EBEBEBEBEBEBEBEBEBEB
        EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB000000000000000000000000000000
        1E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C
        3C1E1E1E000000000000000000000000C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
        C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      Margin = 0
      NumGlyphs = 2
      Spacing = 0
      TabOrder = 2
      TabStop = False
      OnClick = btnPopMenuMarcaClick
    end
    object btnDesmarca: TBitBtnLocked
      Left = 276
      Top = 5
      Width = 110
      Height = 22
      Caption = '[ F8 ] Desmarca Tudo'
      TabOrder = 3
      OnClick = btnDesmarcaClick
    end
    object btnPopMenuDesMarca: TBitBtnLocked
      Left = 385
      Top = 5
      Width = 22
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Enabled = False
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000C40E0000C40E00000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000001E1E1E1E1E1E0000000000000000000000
        00000000000000000000000000000000000000000000000000000000000000C3
        C3C3EBEBEB000000000000000000000000000000000000000000000000000000
        0000000000000000000000001E1E1E3C3C3C3C3C3C1E1E1E0000000000000000
        00000000000000000000000000000000000000000000000000000000C3C3C3EB
        EBEBEBEBEBEBEBEB000000000000000000000000000000000000000000000000
        0000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000000000
        00000000000000000000000000000000000000000000000000C3C3C3EBEBEBEB
        EBEBEBEBEBEBEBEBEBEBEB000000000000000000000000000000000000000000
        0000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000
        00000000000000000000000000000000000000000000C3C3C3EBEBEBEBEBEBEB
        EBEBEBEBEBEBEBEBEBEBEBEBEBEB000000000000000000000000000000000000
        0000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E
        1E000000000000000000000000000000000000C3C3C3EBEBEBEBEBEBEBEBEBEB
        EBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEBEB000000000000000000000000000000
        1E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C
        3C1E1E1E000000000000000000000000C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
        C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      Margin = 0
      NumGlyphs = 2
      Spacing = 0
      TabOrder = 4
      TabStop = False
      OnClick = btnPopMenuDesMarcaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 144
  end
  object popMarca: TPopupMenu
    Left = 464
    Top = 376
    object popEnt: TMenuItem
      Caption = '&Entrega'
      OnClick = popEntClick
    end
    object popRet: TMenuItem
      Caption = '&Retira'
      OnClick = popRetClick
    end
  end
end
