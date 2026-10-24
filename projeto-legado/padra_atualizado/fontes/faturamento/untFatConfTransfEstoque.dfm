inherited frmFatConfTransfEstoque: TfrmFatConfTransfEstoque
  Left = 182
  Top = 115
  Width = 717
  Height = 557
  BorderIcons = [biSystemMenu]
  Caption = 'Confirma'#231#227'o de Transfer'#234'ncia de Estoque'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 717
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 481
    Width = 711
    TabOrder = 3
    ExplicitTop = 481
    ExplicitWidth = 711
    inherited FlwBotoes: TFlowPanel
      Width = 707
      ExplicitWidth = 707
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 512
    Width = 711
    TabOrder = 2
    ExplicitTop = 512
    ExplicitWidth = 711
    inherited pnlNomeForm: TPanel
      Left = 526
      Width = 185
      ExplicitLeft = 526
      ExplicitWidth = 185
    end
    inherited pnlInfo: TPanel
      Width = 526
      ExplicitWidth = 526
    end
  end
  inherited pgcDados: TPageControl
    Left = 495
    Top = 64
    Width = 216
    Height = 417
    TabOrder = 6
    Visible = False
    ExplicitLeft = 495
    ExplicitTop = 64
    ExplicitWidth = 216
    ExplicitHeight = 417
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 208
      ExplicitHeight = 385
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 711
    Height = 64
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
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
      Top = 38
      Width = 54
      Height = 14
      Caption = 'Data Inicial:'
    end
    object Label5: TLabel
      Left = 155
      Top = 38
      Width = 50
      Height = 14
      Caption = 'Data Final:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 74
      Top = 11
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
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
      Width = 535
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 74
      Top = 34
      Width = 71
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 210
      Top = 34
      Width = 71
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object pnlAux2: TPanel [4]
    Left = 0
    Top = 64
    Width = 495
    Height = 417
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object dbgDocumentos: TDBGridCitel
      Left = 0
      Top = 0
      Width = 495
      Height = 417
      Align = alClient
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
          Width = 115
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_ESPDOC'
          Title.Alignment = taCenter
          Title.Caption = 'Esp.'
          Width = 28
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TMP_CODEMP'
          Title.Alignment = taCenter
          Title.Caption = 'Emp.'
          Width = 28
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
          FieldName = 'TMP_ITEDOC'
          Title.Alignment = taRightJustify
          Title.Caption = 'Itens'
          Width = 29
          Visible = True
        end>
    end
  end
  object pnlAux1: TPanel [5]
    Left = 495
    Top = 64
    Width = 216
    Height = 417
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 5
    object pnlDadosDup: TPanel
      Left = 0
      Top = 0
      Width = 216
      Height = 176
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object Label4: TLabel
        Left = 2
        Top = 2
        Width = 212
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
        ExplicitWidth = 218
      end
      object Label3: TLabel
        Left = 17
        Top = 35
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Documento(s):'
      end
      object Label11: TLabel
        Left = 49
        Top = 57
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total L'#237'quido:'
      end
      object edtQtdDoc: TEditFocus
        Left = 114
        Top = 31
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
      object edtTotLiq: TEditFocus
        Left = 114
        Top = 53
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
      Width = 216
      Height = 241
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      object Label16: TLabel
        Left = 2
        Top = 2
        Width = 212
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
        ExplicitWidth = 218
      end
      object Label6: TLabel
        Left = 17
        Top = 38
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Documento(s):'
      end
      object Label17: TLabel
        Left = 49
        Top = 60
        Width = 62
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total L'#237'quido:'
      end
      object edtQtdDocSel: TEditFocus
        Left = 114
        Top = 34
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
      object edtTotLiqSel: TEditFocus
        Left = 114
        Top = 56
        Width = 72
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
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
    Width = 711
    Height = 31
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object btnItensDoc: TBitBtnLocked
      Left = 4
      Top = 5
      Width = 137
      Height = 22
      Caption = '[ F5 ] Itens do Documento'
      TabOrder = 0
      OnClick = btnItensDocClick
    end
    object btnConfirma: TBitBtnLocked
      Left = 418
      Top = 5
      Width = 129
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 5
      OnClick = btnConfirmaClick
    end
    object btnSairConf: TBitBtnLocked
      Left = 582
      Top = 5
      Width = 111
      Height = 22
      Caption = '[ Esc ] Sair'
      TabOrder = 6
      OnClick = btnSairConfClick
    end
    object btnMarca: TBitBtnLocked
      Left = 143
      Top = 5
      Width = 110
      Height = 22
      Caption = '[ F7 ] Marcar Todos'
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
      Width = 119
      Height = 22
      Caption = '[ F8 ] Desmarcar Todos'
      TabOrder = 3
      OnClick = btnDesmarcaClick
    end
    object btnPopMenuDesMarca: TBitBtnLocked
      Left = 394
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
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 160
    Top = 16
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
