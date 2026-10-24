inherited frmRelRcxResumoCaixa: TfrmRelRcxResumoCaixa
  Left = 365
  Top = 157
  Width = 343
  Height = 624
  Caption = 'Relat'#243'rio de Resumo de Caixa'
  OnDestroy = FormDestroy
  ExplicitWidth = 343
  ExplicitHeight = 624
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 553
    Width = 337
    ExplicitTop = 553
    ExplicitWidth = 337
    inherited FlwBotoes: TFlowPanel
      Width = 256
      ExplicitWidth = 256
    end
    inherited btnSair: TBitBtnLocked
      Left = 258
      ExplicitLeft = 258
    end
  end
  inherited pnlDados: TPanel
    Width = 337
    Height = 553
    ExplicitWidth = 337
    ExplicitHeight = 553
    object Label12: TLabel [0]
      Left = 8
      Top = 6
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDesDtaIni: TLabel [1]
      Left = 103
      Top = 24
      Width = 68
      Height = 14
      Caption = '(CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDesDtaFin: TLabel [2]
      Left = 103
      Top = 63
      Width = 68
      Height = 14
      Caption = '(CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel [3]
      Left = 8
      Top = 45
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [4]
      Left = 8
      Top = 84
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [5]
      Left = 8
      Top = 160
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador'
    end
    object Label4: TLabel [6]
      Left = 8
      Top = 198
      Width = 94
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo de Operador'
    end
    object Label3: TLabel [7]
      Left = 8
      Top = 236
      Width = 117
      Height = 14
      Caption = 'Seq. fechamento parcial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCaixa: TLabel [8]
      Left = 8
      Top = 122
      Width = 27
      Height = 14
      Alignment = taRightJustify
      Caption = 'Caixa'
    end
    inherited gpbDestino: TGroupBox
      Left = 8
      Top = 274
      Width = 151
      TabOrder = 11
      ExplicitLeft = 8
      ExplicitTop = 274
      ExplicitWidth = 151
      inherited ColorLabel1: TColorLabel
        Left = 30
        ExplicitLeft = 30
      end
      inherited edtDestino: TEditFocus
        Left = 8
        ExplicitLeft = 8
      end
    end
    object mskEspecie: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 98
      Width = 173
      Height = 22
      CharCase = ecUpperCase
      EditMask = 'll-ll-ll-ll-ll-ll-ll-ll-ll-ll;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 29
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      Text = '  -  -  -  -  -  -  -  -  -  '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodOpe: TEditFocus
      Left = 8
      Top = 174
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnChange = edtCodOpeChange
      OnExit = edtCodOpeExit
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesOperador: TEditFocus
      Left = 52
      Top = 174
      Width = 265
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
    object edtGruGpo: TEditFocus
      Left = 8
      Top = 212
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 6
      OnChange = edtGruGpoChange
      OnExit = edtGruGpoExit
      OnKeyPress = edtGruGpoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesGpo: TEditFocus
      Left = 52
      Top = 212
      Width = 265
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSeqFec: TEditFocus
      Left = 8
      Top = 250
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object chkCredito: TCheckBox
      Left = 166
      Top = 240
      Width = 149
      Height = 17
      Caption = 'Exibir rela'#231#227'o de cr'#233'ditos'
      TabOrder = 9
    end
    object gpbTipo: TGroupBox
      Left = 166
      Top = 274
      Width = 151
      Height = 45
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      object ColorLabel2: TColorLabel
        Left = 30
        Top = 20
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtTipo: TEditFocus
        Tag = 99
        Left = 8
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'A'
        OnChange = edtTipoChange
        OnExit = edtTipoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object gpbExiDta: TGroupBox
      Left = 166
      Top = 321
      Width = 151
      Height = 45
      Caption = 'Exibir Data do Movimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      object ColorLabel4: TColorLabel
        Left = 30
        Top = 20
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtExiDta: TEditFocus
        Tag = 99
        Left = 8
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'N'
        OnChange = edtTipoChange
        OnExit = edtTipoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 321
      Width = 151
      Height = 45
      Caption = 'Visualiza'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      object ColorLabel3: TColorLabel
        Left = 30
        Top = 20
        Width = 108
        Height = 14
        Caption = '(E)sp Doc (S)eq Baixa'
        CorDestaque = clRed
      end
      object edtVisualizacao: TEditFocus
        Tag = 99
        Left = 8
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'E'
        OnChange = edtVisualizacaoChange
        OnExit = edtVisualizacaoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object rdgEmpresa: TRadioGroup
      Left = 8
      Top = 368
      Width = 309
      Height = 40
      Caption = 'Empresa'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Faturamento'
        'Origem')
      TabOrder = 15
    end
    object chkCancelados: TCheckBox
      Left = 8
      Top = 414
      Width = 265
      Height = 17
      Caption = 'Exibir o Total de documentos cancelados?'
      Checked = True
      State = cbChecked
      TabOrder = 16
    end
    object chkRelAbast: TCheckBox
      Left = 8
      Top = 430
      Width = 265
      Height = 17
      Caption = 'Gerar o pedido de abastecimento?'
      TabOrder = 17
      Visible = False
      OnClick = chkRelAbastClick
    end
    object chkDesFpg: TCheckBox
      Left = 166
      Top = 257
      Width = 149
      Height = 17
      Caption = 'Desmembrar Formas Pgto.'
      TabOrder = 10
    end
    object prbProgesso: TcxProgressBar
      Left = 1
      Top = 530
      Align = alBottom
      TabOrder = 23
      Visible = False
      ExplicitTop = 531
      Width = 335
    end
    object chkListVenPraz: TCheckBox
      Left = 8
      Top = 446
      Width = 307
      Height = 17
      Caption = 'Exibir listagem de vendas a prazo para confer'#234'ncia?'
      TabOrder = 18
    end
    object chkTipRec: TCheckBox
      Left = 8
      Top = 462
      Width = 289
      Height = 17
      Caption = 'Quebrar por tipo de Recebimento ('#192' Vista / A Prazo)'
      TabOrder = 19
      OnClick = chkTipRecClick
    end
    object chkSeparaDtaCad: TCheckBox
      Left = 8
      Top = 478
      Width = 243
      Height = 17
      Caption = 'Separar movimenta'#231#245'es de dias anteriores'
      TabOrder = 20
      OnClick = chkTipRecClick
    end
    object chkLDPGInicio: TCheckBox
      Left = 8
      Top = 494
      Width = 324
      Height = 17
      Caption = 'Exibir listagem de pagamentos (LD e PG) no in'#237'cio do relat'#243'rio'
      Enabled = False
      TabOrder = 21
    end
    object chkNaoExibeCheque: TCheckBox
      Left = 8
      Top = 510
      Width = 324
      Height = 17
      Caption = 'N'#227'o exibir detalhamento de cheques '#224' vista e/ou pr'#233'-detados'
      TabOrder = 22
    end
    object edtCodigoCaixa: TEditFocus
      Tag = 99
      Left = 8
      Top = 136
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 3
      OnKeyPress = edtCodigoCaixaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDescricaoCaixa: TEditFocus
      Left = 52
      Top = 136
      Width = 265
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 24
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 8
      Top = 20
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 0
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 8
      Top = 59
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 1
      Width = 90
    end
  end
  inherited pnlStatus: TPanel
    Top = 579
    Width = 337
    ExplicitTop = 579
    ExplicitWidth = 337
    inherited pnlNomeForm: TPanel
      Left = 166
      ExplicitLeft = 166
    end
    inherited pnlInfo: TPanel
      Width = 166
      ExplicitWidth = 166
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 168
    Top = 72
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 232
    Top = 104
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 168
    Top = 40
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 264
    Top = 72
  end
  inherited frxGen: TfrxUserDataSet
    Fields.Strings = (
      'EMP_NOMEMP'
      'EMP_NOMFAN'
      'REL_NOMREL')
    Left = 296
    Top = 72
  end
  inherited frxDesigner: TfrxDesigner
    Left = 200
    Top = 72
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 232
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
  end
  object frxResumo: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxResumo'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 264
    Top = 104
  end
  object frxCheques: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxCheques'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 296
    Top = 104
  end
  object frxDuplicatas: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxDuplicatas'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 200
    Top = 40
  end
  object frxResumoVendas: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxResumoVendas'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 232
    Top = 40
  end
  object frxCredito: TfrxDBDataset
    Description = 'Resumo de Creditos'
    UserName = 'frxCredito'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 264
    Top = 40
  end
  object cdsVenPra: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 136
    object cdsVenPraDESFPG: TStringField
      FieldName = 'DESFPG'
      Size = 35
    end
    object cdsVenPraVALFPG: TFloatField
      FieldName = 'VALFPG'
    end
  end
  object cdsVenVis: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 136
    object cdsVenVisDESFPG: TStringField
      FieldName = 'DESFPG'
      Size = 35
    end
    object cdsVenVisVALFPG: TFloatField
      FieldName = 'VALFPG'
    end
  end
  object frxVenVis: TfrxDBDataset
    UserName = 'frxVenVis'
    CloseDataSource = False
    DataSet = cdsVenVis
    BCDToCurrency = False
    Left = 233
    Top = 136
  end
  object frxVenPra: TfrxDBDataset
    UserName = 'frxVenPra'
    CloseDataSource = False
    DataSet = cdsVenPra
    BCDToCurrency = False
    Left = 201
    Top = 136
  end
  object frxResumoEspecies: TfrxDBDataset
    Description = 'Resumo de Creditos'
    UserName = 'frxResumoEspecies'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 231
    Top = 167
  end
  object frxResumofPG: TfrxDBDataset
    UserName = 'frxResumoFpg'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 264
    Top = 169
  end
  object frxListVenPraz: TfrxDBDataset
    UserName = 'frxListVenPraz'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 296
    Top = 169
  end
  object frxPagamento: TfrxDBDataset
    UserName = 'frxPagamento'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 200
    Top = 168
  end
  object frxResFat: TfrxDBDataset
    UserName = 'frxResFat'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 208
    Top = 208
  end
  object frxDupJus: TfrxDBDataset
    UserName = 'frxDupJus'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 240
    Top = 208
  end
  object frxDetOutrosFpg: TfrxDBDataset
    UserName = 'frxDetOutrosFpg'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 264
    Top = 209
  end
  object frxFechamentos: TfrxDBDataset
    UserName = 'frxFechamentos'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 296
    Top = 417
  end
  object frxLacresMalotes: TfrxDBDataset
    UserName = 'frxLacresMalotes'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 288
    Top = 456
  end
end
