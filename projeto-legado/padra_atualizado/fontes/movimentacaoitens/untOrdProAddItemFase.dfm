inherited frmOrdProAddItemFase: TfrmOrdProAddItemFase
  Left = 401
  Top = 270
  Width = 876
  Height = 414
  BorderIcons = [biSystemMenu]
  Caption = 'Adicionar produtos a fase'
  Position = poScreenCenter
  ExplicitWidth = 876
  ExplicitHeight = 414
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 341
    Width = 870
    TabOrder = 1
    ExplicitTop = 341
    ExplicitWidth = 870
    DesignSize = (
      870
      28)
    object Label7: TLabel [0]
      Left = 112
      Top = 6
      Width = 65
      Height = 14
      Caption = '[DEL] Apaga'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblInfLot: TLabel [1]
      Left = 360
      Top = 7
      Width = 86
      Height = 14
      Caption = 'Informar o Lote'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSaldoLote: TLabel [2]
      Left = 470
      Top = 7
      Width = 101
      Height = 14
      Caption = 'Saldo Insuficiente '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lnlItemInativo: TLabel [3]
      Left = 590
      Top = 7
      Width = 64
      Height = 14
      Caption = 'Item Inativo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object shpInfLot: TShape [4]
      Left = 340
      Top = 6
      Width = 16
      Height = 16
      Brush.Color = clRed
    end
    object shpItemInativo: TShape [5]
      Left = 570
      Top = 6
      Width = 16
      Height = 16
      Brush.Color = clAqua
    end
    object shpSaldoLote: TShape [6]
      Left = 450
      Top = 6
      Width = 16
      Height = 16
      Brush.Color = 33023
    end
    inherited FlwBotoes: TFlowPanel
      Width = 866
      ExplicitWidth = 866
    end
    inherited btnSair: TBitBtnLocked
      Left = 787
      TabOrder = 2
      ExplicitLeft = 787
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 100
      Height = 22
      Caption = '[ F10 ] Fechamento'
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
    object btnRelSaldoInsuficiente: TBitBtnLocked
      Left = 685
      Top = 3
      Width = 93
      Height = 22
      Caption = 'Rel. Saldo Insuf'
      Enabled = False
      TabOrder = 3
      Visible = False
      OnClick = btnRelSaldoInsuficienteClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 369
    Width = 870
    TabOrder = 2
    ExplicitTop = 369
    ExplicitWidth = 870
    inherited pnlNomeForm: TPanel
      Left = 699
      ExplicitLeft = 699
    end
    inherited pnlInfo: TPanel
      Width = 699
      ExplicitWidth = 699
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 870
    Height = 341
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object dbgDados: TDBGridCitel
      Left = 1
      Top = 160
      Width = 868
      Height = 180
      Align = alClient
      ImeName = ' '
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgDadosDrawColumnCell
      OnKeyDown = dbgDadosKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'ITESUB'
          Title.Caption = 'Codigo'
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODFAB'
          Title.Caption = 'C'#243'd. F'#225'brica'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESITE'
          Title.Caption = 'Descri'#231#227'o'
          Width = 320
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REFERE'
          Title.Caption = 'Referencia'
          Width = 100
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'QTDITE'
          Title.Alignment = taCenter
          Title.Caption = 'Quantidade'
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'METRAG'
          Title.Caption = 'Metragem'
          Width = 55
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'QTDTOT'
          Title.Alignment = taCenter
          Title.Caption = 'Qtd. Total'
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALDOS'
          Title.Caption = 'Saldo'
          Width = 90
          Visible = True
        end>
    end
    object pnlSubProdutos: TPanel
      Left = 1
      Top = 58
      Width = 868
      Height = 80
      Align = alTop
      Color = 16770261
      TabOrder = 0
      object Label2: TLabel
        Left = 30
        Top = 10
        Width = 65
        Height = 14
        Caption = 'Sub. Produto:'
      end
      object Label3: TLabel
        Left = 40
        Top = 33
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Referencia:'
      end
      object Label4: TLabel
        Left = 232
        Top = 33
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
      end
      object Label6: TLabel
        Left = 40
        Top = 56
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object lblNumLot: TColorLabel
        Left = 333
        Top = 56
        Width = 24
        Height = 14
        Alignment = taRightJustify
        Caption = 'Lote:'
        Visible = False
        CorDestaque = clRed
      end
      object lblMetrag: TLabel
        Left = 187
        Top = 56
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Metragem:'
      end
      object edtDesSubProduto: TEditFocus
        Left = 151
        Top = 6
        Width = 682
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
      object edtSubProduto: TEditFocus
        Tag = 99
        Left = 99
        Top = 6
        Width = 51
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtSubProdutoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtSubReferencia: TEditFocus
        Left = 99
        Top = 29
        Width = 118
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtSubUnidade: TEditFocus
        Left = 275
        Top = 29
        Width = 41
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtSubQtdIte: TEditFocus
        Tag = 99
        Left = 99
        Top = 52
        Width = 78
        Height = 22
        Alignment = taRightJustify
        Color = clWhite
        MaxLength = 10
        TabOrder = 4
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 10
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object btnAdicionar: TBitBtnLocked
        Left = 461
        Top = 32
        Width = 111
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 7
        OnClick = btnAdicionarClick
      end
      object btnCancelaItem: TBitBtnLocked
        Left = 575
        Top = 32
        Width = 111
        Height = 22
        Caption = 'C&ancelar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
          015603015603FF00FF0000820000820000820000820000820000820000820000
          820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
          27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
          30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
          FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
          0082000082000082000082000082000082000082000082000082FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
          00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
          0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
          50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
          5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
          8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 8
        OnClick = btnCancelaItemClick
      end
      object edtNumLot: TEditFocus
        Tag = 99
        Left = 363
        Top = 52
        Width = 93
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 30
        TabOrder = 6
        Visible = False
        OnKeyPress = edtNumLotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMetrag: TEditFocus
        Tag = 99
        Left = 238
        Top = 52
        Width = 78
        Height = 22
        Alignment = taRightJustify
        Color = clWhite
        MaxLength = 10
        TabOrder = 5
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 10
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlProdutos: TPanel
      Left = 1
      Top = 1
      Width = 868
      Height = 57
      Align = alTop
      Color = 16770261
      Enabled = False
      TabOrder = 2
      object Label1: TLabel
        Left = 9
        Top = 9
        Width = 86
        Height = 14
        Caption = 'Produto Acabado:'
      end
      object Label5: TLabel
        Left = 40
        Top = 32
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Referencia:'
      end
      object Label10: TLabel
        Left = 232
        Top = 32
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
      end
      object lblCodFabrica: TLabel
        Left = 329
        Top = 32
        Width = 64
        Height = 14
        Caption = 'C'#243'd. F'#225'brica:'
      end
      object edtDesProduto: TEditFocus
        Left = 151
        Top = 5
        Width = 682
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
      object edtProdutos: TEditFocus
        Tag = 99
        Left = 99
        Top = 5
        Width = 51
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtReferencia: TEditFocus
        Left = 99
        Top = 28
        Width = 118
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUnidade: TEditFocus
        Left = 275
        Top = 28
        Width = 41
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodFab: TEditFocus
        Left = 399
        Top = 28
        Width = 114
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlTituloFase: TPanel
      Left = 1
      Top = 138
      Width = 868
      Height = 22
      Align = alTop
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 8
  end
end
