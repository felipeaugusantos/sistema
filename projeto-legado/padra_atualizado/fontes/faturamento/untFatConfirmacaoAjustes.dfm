inherited frmFatConfirmacaoAjustes: TfrmFatConfirmacaoAjustes
  Left = 111
  Top = 174
  Width = 800
  Height = 565
  BorderStyle = bsDialog
  Caption = 'Confirma'#231#227'o de Ajustes de Estoque'
  ExplicitWidth = 800
  ExplicitHeight = 565
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 494
    Width = 794
    Height = 26
    TabOrder = 6
    ExplicitTop = 494
    ExplicitWidth = 794
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 685
      Height = 22
      ExplicitWidth = 685
      ExplicitHeight = 22
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 130
        ExplicitWidth = 130
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 130
        Width = 130
        ExplicitLeft = 130
        ExplicitWidth = 130
      end
      object btnConfirmacao: TBitBtnLocked
        Left = 260
        Top = 0
        Width = 130
        Height = 22
        Caption = '[ F10 ] Confirma'#231#227'o'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnConfirmacaoClick
      end
      object btnMarcar: TBitBtnLocked
        Left = 390
        Top = 0
        Width = 130
        Height = 22
        Caption = '[ F6 ] Marcar Todos'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
          83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
          DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
          AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
          00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
          E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
          3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
          0066000066000066000066000066000066000066000066000066000066000066
          00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
          ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
          CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
          00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
          F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
          0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
          D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
          2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
          43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
          DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
          FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
          0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
          82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 3
        OnClick = btnMarcarClick
      end
      object btnDesmarcar: TBitBtnLocked
        Left = 520
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F7 ] Desmarcar Todos'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
          83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
          DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
          AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
          00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
          E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF00009A
          00009A00009A00009A00009A00009A00009A00009A00009A00009A00009A0000
          9A00009A00009A00009AFF00FF00009ABB8E80FAF0DF00009AF9ECD6F9E9D100
          009A00009A00009A00009A00009A00009AF4DAB2B3897B00009AFF00FF00009A
          00009A00009A00009A00009A00009A00009A00009A00009A00009A00009A0000
          9A00009A00009A00009AFF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
          ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
          CB9C86FCF7EE006600FBF3E6FAF1E19933009933009933009933009933009933
          00F6E2C1B3897BFF00FFFF00FFFF00FFCFA089FDF9F2FDF7EEFBF5EBFCF4E6FB
          F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
          9F7B67BEBBB8BEBBB6BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
          D1F7E6CCB3897BFF00FF00009A00009A00009A00009A00009A00009A00009A73
          2600993300993300993300993300993300F8E9D2B3897BFF00FF00009A4A79FF
          2F62FF0D43FF002BF6021AD100009ABEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
          DCF9EBD7B3897BFF00FF00009A00009A00009A00009A00009A00009A00009AFD
          FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
          DEAD8EDAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA482DAA4
          82DAA482DAA482FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 4
        OnClick = btnDesmarcarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 687
      Top = 2
      Width = 105
      Align = alRight
      Caption = '[ Esc ] &Cancelar'
      ExplicitLeft = 687
      ExplicitTop = 2
      ExplicitWidth = 105
    end
  end
  inherited pnlHeader: TPanel
    Width = 794
    Height = 59
    TabOrder = 0
    ExplicitWidth = 794
    ExplicitHeight = 59
    object Label1: TLabel
      Left = 15
      Top = 34
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 11
      Top = 11
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label3: TLabel
      Left = 125
      Top = 12
      Width = 7
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 52
      Top = 30
      Width = 68
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 2
      OnEnter = edtCodCliEnter
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 120
      Top = 30
      Width = 377
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 52
      Top = 7
      Width = 68
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnEnter = edtCodCliEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 138
      Top = 7
      Width = 69
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnEnter = edtCodCliEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  inherited pnlTail: TPanel
    Top = 434
    Width = 794
    Height = 60
    TabOrder = 5
    Visible = True
    ExplicitTop = 434
    ExplicitWidth = 794
    ExplicitHeight = 60
    object lblTotImp: TLabel
      Left = 523
      Top = 12
      Width = 161
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total Entradas Selecionado:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 533
      Top = 36
      Width = 151
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Total Sa'#237'das Selecionado:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtTotEntSel: TEditFocus
      Left = 687
      Top = 8
      Width = 100
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotSaiSel: TEditFocus
      Left = 687
      Top = 32
      Width = 100
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = '0,00'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 99
    Width = 794
    Height = 259
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    Columns = <
      item
        Expanded = False
        FieldName = 'DET_DTAENT'
        ReadOnly = True
        Title.Caption = 'Data Emiss'#227'o'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_HORENT'
        ReadOnly = True
        Title.Caption = 'Hora Emiss'#227'o'
        Width = 71
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DET_NUMDOC'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'N'#186' Documento'
        Width = 77
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DET_ESPDOC'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Esp'#233'cie'
        Width = 47
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DET_CODEMP'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Width = 50
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DET_CODVEN'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Vendedor'
        Width = 53
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DET_QTDENT'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd. Itens Ent.'
        Width = 90
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DET_TOTENT'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Total Ent.'
        Width = 90
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DET_QTDSAI'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd. Itens Sa'#237'da'
        Width = 90
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DET_TOTSAI'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Total Sa'#237'da'
        Width = 90
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 59
    Width = 794
    TabOrder = 1
    ExplicitTop = 59
    ExplicitWidth = 794
  end
  object pnlProgressoDetalhes: TPanel [6]
    Left = 0
    Top = 396
    Width = 794
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    Visible = False
    object pgbProgressoDetalhes: TGauge
      Left = 0
      Top = 24
      Width = 794
      Height = 14
      Align = alBottom
      ForeColor = clBlue
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Progress = 0
      ExplicitLeft = 1
      ExplicitTop = 21
      ExplicitWidth = 383
    end
    object lblProgressoDetalhes: TLabel
      Left = 0
      Top = 0
      Width = 70
      Height = 24
      Align = alLeft
      Caption = 'Aguarde...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 14
    end
  end
  object pnlProgressoGeral: TPanel [7]
    Left = 0
    Top = 358
    Width = 794
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    Visible = False
    object pgbProgressoGeral: TGauge
      Left = 0
      Top = 23
      Width = 794
      Height = 15
      Align = alBottom
      ForeColor = clBlue
      Progress = 0
      ExplicitLeft = 1
      ExplicitTop = 25
      ExplicitWidth = 383
    end
    object lblProgressoGeral: TLabel
      Left = 0
      Top = 0
      Width = 70
      Height = 23
      Align = alLeft
      Caption = 'Aguarde...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 14
    end
  end
  inherited pnlStatus: TPanel
    Top = 520
    Width = 794
    TabOrder = 7
    ExplicitTop = 520
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 376
    Top = 240
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 664
  end
  inherited qryConsulta: TUniQuery
    Left = 232
    Top = 240
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 264
    Top = 240
  end
  inherited cdsConsulta: TUniClientDataSet
    AggregatesActive = True
    Left = 296
    Top = 240
  end
  inherited dtsConsulta: TDataSource
    Left = 328
    Top = 240
  end
end
