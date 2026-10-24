inherited frmCadCotItens: TfrmCadCotItens
  Left = 195
  Top = 263
  VertScrollBar.Range = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'frmCadCotItens'
  ClientHeight = 600
  ClientWidth = 1392
  ExplicitWidth = 1392
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  object splAplicacao: TSplitter [0]
    Left = 0
    Top = 228
    Width = 1392
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    Beveled = True
    Color = clYellow
    MinSize = 20
    ParentColor = False
    ResizeStyle = rsNone
    OnCanResize = splAplicacaoCanResize
    ExplicitTop = 285
    ExplicitWidth = 1274
  end
  object splGiro: TSplitter [1]
    Left = 0
    Top = 291
    Width = 1392
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    Beveled = True
    Color = clYellow
    MinSize = 20
    ParentColor = False
    ResizeStyle = rsNone
    ExplicitTop = 392
  end
  inherited pnlBotoes: TPanel
    Top = 539
    Width = 1392
    Height = 45
    BevelInner = bvNone
    BevelOuter = bvNone
    ParentColor = True
    ExplicitTop = 539
    ExplicitWidth = 1392
    ExplicitHeight = 45
    DesignSize = (
      1392
      45)
    object lblExiApli: TLabel [0]
      Left = 718
      Top = 6
      Width = 158
      Height = 14
      Cursor = crHandPoint
      Caption = 'Ocultar Aplica'#231#227'o do Produto'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold, fsUnderline]
      ParentColor = False
      ParentFont = False
      OnClick = lblExiApliClick
    end
    inherited btnSair: TBitBtnLocked
      Left = 1307
      Top = 22
      TabOrder = 4
      Visible = False
      ExplicitLeft = 1307
      ExplicitTop = 22
    end
    inherited btnPesquisar: TBitBtnLocked
      Left = 276
      Top = 0
      TabOrder = 3
      ExplicitLeft = 276
      ExplicitTop = 0
    end
    inherited btnMudaOrdem: TBitBtnLocked
      Left = 158
      Top = 0
      TabOrder = 2
      ExplicitLeft = 158
      ExplicitTop = 0
    end
    object btnIncluir: TBitBtnLocked
      Left = 15
      Top = 0
      Width = 71
      Height = 22
      Caption = '&Incluir'
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
      TabOrder = 0
      OnClick = btnIncluirClick
    end
    object btnExcluir: TBitBtnLocked
      Left = 86
      Top = 0
      Width = 72
      Height = 22
      Caption = '&Excluir'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
        00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
        00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
        DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
        006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
        16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
        20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
        00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
        00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
        E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnExcluirClick
    end
    object btnGiroEst: TBitBtnLocked
      Left = 375
      Top = 0
      Width = 147
      Height = 22
      Caption = '[F6] Giro de &Estoque'
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
      TabOrder = 5
      OnClick = btnGiroEstClick
    end
    object btnImporta: TBitBtnLocked
      Left = 522
      Top = 0
      Width = 149
      Height = 22
      Caption = '[F7] Importar Requisi'#231#227'o'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
        FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
        00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
        F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
        00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
        F033777777777337F73309999990FFF0033377777777FFF77333099999000000
        3333777777777777333333399033333333333337773333333333333903333333
        3333333773333333333333303333333333333337333333333333}
      NumGlyphs = 2
      TabOrder = 6
      OnClick = btnImportaClick
    end
    object btnPrepTE: TBitBtnLocked
      Left = 522
      Top = 22
      Width = 149
      Height = 22
      Caption = '[F8] Prepara Gera'#231#227'o TE'
      NumGlyphs = 2
      TabOrder = 7
      OnClick = btnPrepTEClick
    end
    object btnSemelhantes: TBitBtnLocked
      Left = 375
      Top = 22
      Width = 147
      Height = 23
      Caption = '[ F9 ] Semelhantes'
      TabOrder = 8
      OnClick = btnSemelhantesClick
    end
    object btnSimilares: TBitBtnLocked
      Left = 276
      Top = 22
      Width = 99
      Height = 23
      Caption = '[ F11 ] Similares'
      TabOrder = 9
      OnClick = btnSimilaresClick
    end
  end
  inherited pnlHeader: TPanel
    Width = 1392
    Height = 6
    Visible = False
    ExplicitWidth = 1392
    ExplicitHeight = 6
  end
  inherited pnlTail: TPanel
    Top = 499
    Width = 1392
    Height = 40
    Visible = True
    ExplicitTop = 499
    ExplicitWidth = 1392
    ExplicitHeight = 40
    object Label5: TLabel
      Left = 10
      Top = 15
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label9: TLabel
      Left = 462
      Top = 18
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 34
      Top = 9
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 100
      Top = 9
      Width = 349
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 57
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
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 522
      Top = 9
      Width = 87
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 46
    Width = 1392
    Height = 168
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        Title.Caption = 'C'#243'd.Item'
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODFAB'
        Title.Caption = 'C'#243'digo F'#225'brica'
        Width = 135
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODGRU'
        Title.Caption = 'C'#243'd.Grupo'
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 313
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REFERE'
        Title.Caption = 'Refer'#234'ncia'
        Width = 105
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 113
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DTAULT'
        Title.Alignment = taCenter
        Title.Caption = 'Data.'#218'lt.Com.'
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORULT'
        Title.Caption = 'Fornec.'#218'lt.Com.'
        Width = 149
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PREULT'
        Title.Alignment = taRightJustify
        Title.Caption = 'Unit.'#218'lt.Com.'
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESMAR'
        Title.Caption = 'Marca'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODSEM'
        Title.Caption = 'Semelhantes'
        Width = 287
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALDOS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIAEST'
        Title.Alignment = taRightJustify
        Title.Caption = 'Dias Estoque'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DIASUG'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Dias Estoque Qtd. Comprada'
        Visible = False
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 6
    Width = 1392
    ExplicitTop = 6
    ExplicitWidth = 1392
  end
  object lblReq: TPanel [8]
    Left = 0
    Top = 214
    Width = 1392
    Height = 14
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Requisi'#231#245'es: '
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentColor = True
    ParentFont = False
    TabOrder = 6
    Visible = False
  end
  object pnlAplicacao: TPanel [9]
    Left = 0
    Top = 231
    Width = 1392
    Height = 60
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 7
    object pnlTitAplic: TPanel
      Left = 0
      Top = 0
      Width = 1392
      Height = 18
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Aplica'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object dbeAplica: TDBMemoFocus
      Left = 0
      Top = 18
      Width = 1392
      Height = 42
      Align = alClient
      DataField = 'APLICA'
      DataSource = dtsConsulta
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object pnlGiro: TPanel [10]
    Left = 0
    Top = 294
    Width = 1392
    Height = 205
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 8
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 584
    Width = 1392
    Visible = False
    ExplicitTop = 584
    ExplicitWidth = 1392
    inherited pnlNomeForm: TPanel
      Left = 1221
      ExplicitLeft = 1221
    end
    inherited pnlInfo: TPanel
      Width = 1221
      ExplicitWidth = 1221
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 512
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 136
  end
  inherited qryConsulta: TUniQuery
    Top = 160
  end
  inherited dspConsulta: TUniDataSetProvider
    Top = 160
  end
  inherited cdsConsulta: TUniClientDataSet
    AfterPost = cdsConsultaAfterPost
    AfterScroll = cdsConsultaAfterScroll
    Top = 160
  end
  inherited dtsConsulta: TDataSource
    Top = 160
  end
  object dtsIteGir: TDataSource
    Left = 296
    Top = 128
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
