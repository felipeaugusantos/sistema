inherited frmCadPortadores: TfrmCadPortadores
  Left = 251
  Top = 214
  Width = 793
  Height = 562
  Caption = 'Cadastro de Portadores'
  OnDestroy = FormDestroy
  ExplicitWidth = 793
  ExplicitHeight = 562
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 472
    Width = 787
    Height = 45
    ExplicitTop = 429
    ExplicitWidth = 787
    ExplicitHeight = 45
    DesignSize = (
      787
      45)
    inherited FlwBotoes: TFlowPanel
      Width = 783
      Height = 41
      ExplicitTop = 2
      ExplicitWidth = 783
      ExplicitHeight = 41
      inherited btnIncluir: TBitBtnLocked
        Width = 110
        ExplicitWidth = 110
      end
      inherited btnGravar: TBitBtnLocked
        Left = 110
        Width = 110
        ExplicitLeft = 110
        ExplicitWidth = 110
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 220
        Width = 110
        ExplicitLeft = 220
        ExplicitWidth = 110
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 330
        Width = 110
        ExplicitLeft = 330
        ExplicitWidth = 110
      end
      inherited btnCancela: TBitBtnLocked
        Left = 440
        Width = 110
        ExplicitLeft = 440
        ExplicitWidth = 110
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 550
        Width = 110
        ExplicitLeft = 550
        ExplicitWidth = 110
      end
      object btnChqEmi: TBitBtnLocked
        Left = 660
        Top = 0
        Width = 110
        Height = 20
        Caption = 'C&heques Emitidos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF89575389575389575489575389575389575389575389
          5753895753895753FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF895753E7D5C4
          E2CFBCE2CCB8E1CBB5E1CBB4E1CAB5E1CBB6E7D5BD895753FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFAD706BF8EEDDF2E6D7EFE3D3EFE1CEEDDECAEDDDC7ED
          DEC7F6E7CE895753FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB4766DF7EFE3
          F7D5B2F8CBA1F7CBA3F6CBA0F6CA9DF3CFAAF3E6CE895753FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFBB7D6EF7F3EAF6E2CCF6DCC2F4DAC0F3D9BCF3D7B8EE
          D5BAF0E3CB895753FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC4866FFAF6EE
          F6D5B5F3C99FF6CBA3F8CBA1EEC298D4B797D1C9B7895753FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFCA8C72FBF7F2E1D4C6C6B6A7D4C2B1E1CEBBC1AF9D91
          8478918B807E5F58FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD19373FBFBFA
          8890A49A7E659C7F66AC8C6F3B578141628E45465B5C4742FF00FFFF00FFFF00
          FF413D3D2D2A2A2D2A2AD79974FEFEFE3B57813B578182807F3B578162B4E03B
          57812A3B69373347FF00FF7676773A3A3A413D3D242325413B3BDA9D75FFFFFF
          3B5781BCEAF33B578162B4E03B578162B4E03B5781273F7321346A767677787D
          83413D3D383435413B3BE7AB79FFFFFFFBFBFC3B5781BCEAF33B578162B4E03B
          578162B4E04398E33481DC767677EDEDED413D3D4D4948484343E7AB79F8EEE7
          F8EEE7F6EBE63B57818FE2F03B578162B4E053ACEA4397E23481DC767677EDED
          ED413D3D5A57575B5959E7AB79D79F80D8A181D8A181D19D803B57817FB1CEB4
          E5F353AFED4399E5244283767677EDEDED413D3D737373737373FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF4F7EAF4074B73B528EFF00FF7676777676
          77413D3D7373735F5E5EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF413D3D413D3D413D3D}
        ParentFont = False
        TabOrder = 6
        OnClick = btnChqEmiClick
      end
      object btnAceOpe: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 110
        Height = 20
        Caption = 'Acesso &Operadores'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = btnAceOpeClick
      end
      object btnPlaNco: TBitBtnLocked
        Left = 110
        Top = 20
        Width = 110
        Height = 20
        Caption = 'Plano de Contas'
        TabOrder = 8
        OnClick = btnPlaNcoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 662
      Top = 22
      Width = 110
      Height = 20
      Anchors = [akLeft, akRight, akBottom]
      ExplicitLeft = 662
      ExplicitTop = 22
      ExplicitWidth = 110
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 517
    Width = 787
    ExplicitTop = 474
    ExplicitWidth = 787
    inherited pnlNomeForm: TPanel
      Left = 592
      Width = 195
      ExplicitLeft = 592
      ExplicitWidth = 195
    end
    inherited pnlInfo: TPanel
      Width = 592
      ExplicitWidth = 592
    end
  end
  inherited pgcDados: TPageControl
    Width = 787
    Height = 472
    ExplicitWidth = 787
    ExplicitHeight = 429
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 779
      ExplicitHeight = 397
      object Label1: TLabel
        Left = 76
        Top = 8
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 58
        Top = 31
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Inicial:'
      end
      object Label4: TLabel
        Left = 82
        Top = 54
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label5: TLabel
        Left = 384
        Top = 123
        Width = 172
        Height = 14
        Caption = 'Dias para cr'#233'dito do valor recebido:'
      end
      object Label6: TLabel
        Left = 489
        Top = 77
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sigla Cont'#225'bil:'
      end
      object Label7: TLabel
        Left = 78
        Top = 100
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Banco:'
      end
      object lblCarteira: TLabel
        Left = 2
        Top = 123
        Width = 110
        Height = 14
        Alignment = taRightJustify
        Caption = 'Carteira (Imp. Boletos):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblCCaVinc: TLabel
        Left = 52
        Top = 146
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ag'#234'ncia/CC:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblCompDescri: TLabel
        Left = 324
        Top = 274
        Width = 226
        Height = 14
        Caption = 'gravar movimento banc'#225'rio no pr'#243'ximo dia '#250'til?'
      end
      object lblDesPlaCon: TLabel
        Left = 40
        Top = 77
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Conta Cont'#225'bil:'
      end
      object lblModalidades: TLabel
        Left = 618
        Top = 137
        Width = 95
        Height = 14
        Cursor = crHandPoint
        Caption = 'Op'#231#245'es de Sele'#231#227'o'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = lblModalidadesClick
      end
      object lblCompDescriEntPco: TLabel
        Left = 24
        Top = 375
        Width = 108
        Height = 14
        Caption = 'An'#225'lise de Resultados'
      end
      object shpAltDtaIni: TShape
        Left = 115
        Top = 28
        Width = 8
        Height = 22
      end
      object lblFornecedorFiscal: TLabel
        Left = 22
        Top = 169
        Width = 90
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor Fiscal:'
      end
      object btnVincCCa: TBitBtnLocked
        Left = 296
        Top = 143
        Width = 64
        Height = 22
        Caption = '&Vincular'
        Enabled = False
        TabOrder = 12
        TabStop = False
        OnClick = btnVincCCaClick
      end
      object cbxCarteira: TComboBoxFocus
        Tag = 99
        Left = 115
        Top = 120
        Width = 244
        Height = 22
        Style = csDropDownList
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object chkBaiUtl: TDBCheckBox
        Left = 307
        Top = 260
        Width = 322
        Height = 16
        Caption = 'Na baixa de contas a receber em s'#225'bado, domingo ou feriado '
        DataField = 'POR_BAIUTL'
        DataSource = dtsCadPor
        TabOrder = 30
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnEnter = chkBaiUtlEnter
        OnExit = chkBaiUtlExit
        OnMouseEnter = chkBaiUtlEnter
        OnMouseLeave = chkBaiUtlExit
      end
      object chkBolFat: TDBCheckBox
        Left = 307
        Top = 243
        Width = 312
        Height = 16
        Caption = 'Permitir utiliza-lo no faturamento para impress'#227'o de boletos?'
        DataField = 'POR_BOLFAT'
        DataSource = dtsCadPor
        TabOrder = 29
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkExiPor: TDBCheckBox
        Left = 307
        Top = 305
        Width = 469
        Height = 16
        Caption = 
          'Exibir t'#237'tulos deste portador na conta corrente e no limite de c' +
          'r'#233'dito do cliente.'
        DataField = 'POR_EXIPOR'
        DataSource = dtsCadPor
        TabOrder = 32
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        WordWrap = True
        OnEnter = chkBaiUtlEnter
        OnExit = chkBaiUtlExit
        OnMouseEnter = chkBaiUtlEnter
        OnMouseLeave = chkBaiUtlExit
      end
      object chkExpAut: TDBCheckBox
        Left = 307
        Top = 288
        Width = 113
        Height = 16
        Caption = 'Exportar pelo Autsi'
        DataField = 'POR_EXPAUT'
        DataSource = dtsCadPor
        TabOrder = 31
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkImpBol: TDBCheckBox
        Left = 8
        Top = 324
        Width = 285
        Height = 16
        Caption = 'Listar Duplicatas na rotina de Impress'#227'o de Boletos?'
        DataField = 'POR_IMPBOL'
        DataSource = dtsCadPor
        TabOrder = 22
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox1: TDBCheckBox
        Left = 8
        Top = 276
        Width = 236
        Height = 16
        Caption = 'Permite Transf'#234'rencia no Resumo de Caixa'
        DataField = 'POR_PERTRA'
        DataSource = dtsCadPor
        TabOrder = 19
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeBaiRcx: TDBCheckBox
        Left = 307
        Top = 226
        Width = 197
        Height = 16
        Caption = 'Permitir Baixa no Resumo de Caixa?'
        DataField = 'POR_BAIRCX'
        DataSource = dtsCadPor
        TabOrder = 28
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeCodBco: TDBEditFocus
        Tag = 99
        Left = 115
        Top = 97
        Width = 62
        Height = 22
        CharCase = ecUpperCase
        DataField = 'POR_CODBCO'
        DataSource = dtsCadPor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnEnter = dbeCodBcoEnter
        OnExit = dbeCodBcoExit
        OnKeyPress = dbeCodBcoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
        OnChamaCadastro = dbeCodBcoChamaCadastro
      end
      object dbeCodPor: TDBEditFocus
        Tag = 99
        Left = 115
        Top = 5
        Width = 97
        Height = 22
        CharCase = ecUpperCase
        DataField = 'POR_CODPOR'
        DataSource = dtsCadPor
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeConCon: TDBEditFocus
        Tag = 99
        Left = 115
        Top = 74
        Width = 367
        Height = 22
        CharCase = ecUpperCase
        DataField = 'POR_CONCON'
        DataSource = dtsCadPor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCtrAna: TDBCheckBox
        Left = 8
        Top = 208
        Width = 285
        Height = 16
        Caption = 'Entra em Contas a Receber na An'#225'lise de Resultados?'
        DataField = 'POR_CTRANA'
        DataSource = dtsCadPor
        TabOrder = 15
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeDCrRec: TDBEditFocus
        Tag = 99
        Left = 558
        Top = 121
        Width = 49
        Height = 22
        CharCase = ecUpperCase
        DataField = 'POR_DCRREC'
        DataSource = dtsCadPor
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeDepChe: TDBCheckBox
        Left = 8
        Top = 242
        Width = 285
        Height = 16
        Caption = 'Permitido no Dep'#243'sito de Cheque?'
        DataField = 'POR_DEPCHE'
        DataSource = dtsCadPor
        TabOrder = 17
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeDtaIni: TDBEditFocus
        Tag = 99
        Left = 124
        Top = 28
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'POR_DTAINI'
        DataSource = dtsCadPor
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeEntAna: TDBCheckBox
        Left = 8
        Top = 191
        Width = 180
        Height = 16
        Caption = 'Entra na An'#225'lise de Resultados?'
        DataField = 'POR_ENTANA'
        DataSource = dtsCadPor
        TabOrder = 14
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeEntBod: TDBCheckBox
        Left = 8
        Top = 258
        Width = 285
        Height = 16
        Caption = 'Entra no boletim di'#225'rio de acompanhamento?'
        DataField = 'POR_ENTBOD'
        DataSource = dtsCadPor
        TabOrder = 18
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeEntFlu: TDBCheckBox
        Left = 8
        Top = 309
        Width = 142
        Height = 16
        Caption = 'Entra no Fluxo de Caixa?'
        DataField = 'POR_ENTFLX'
        DataSource = dtsCadPor
        TabOrder = 21
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeEntPco: TDBCheckBox
        Left = 8
        Top = 356
        Width = 285
        Height = 20
        Caption = 'Entra na Posi'#231#227'o Cont'#225'bil/Contas a Receber na'
        DataField = 'POR_ENTPCO'
        DataSource = dtsCadPor
        TabOrder = 24
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        WordWrap = True
      end
      object dbeMovBan: TDBCheckBox
        Left = 307
        Top = 209
        Width = 166
        Height = 16
        Caption = 'Permitir Movimento Banc'#225'rio?'
        DataField = 'POR_MOVBAN'
        DataSource = dtsCadPor
        TabOrder = 27
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeNomPor: TDBEditFocus
        Tag = 99
        Left = 115
        Top = 51
        Width = 492
        Height = 22
        CharCase = ecUpperCase
        DataField = 'POR_NOMPOR'
        DataSource = dtsCadPor
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePerBai: TDBCheckBox
        Left = 307
        Top = 191
        Width = 188
        Height = 16
        Caption = 'Permitir Baixa CTP/CTR/CHQ/CAR?'
        DataField = 'POR_PERBAI'
        DataSource = dtsCadPor
        TabOrder = 26
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbePlaNco: TDBEditFocus
        Tag = 99
        Left = 115
        Top = 74
        Width = 135
        Height = 22
        DataField = 'POR_PLANCO'
        DataSource = dtsCadPor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnKeyPress = dbePlaNcoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSalPor: TDBCheckBox
        Left = 8
        Top = 292
        Width = 191
        Height = 16
        Caption = 'Entra no Saldo por Portador?'
        DataField = 'POR_SALPOR'
        DataSource = dtsCadPor
        TabOrder = 20
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeSigCon: TDBEditFocus
        Tag = 99
        Left = 558
        Top = 75
        Width = 49
        Height = 22
        CharCase = ecUpperCase
        DataField = 'POR_SIGCON'
        DataSource = dtsCadPor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTransf: TDBCheckBox
        Left = 8
        Top = 225
        Width = 285
        Height = 16
        Caption = 'Utilizado para Transfer'#234'ncia?'
        DataField = 'POR_TRANSF'
        DataSource = dtsCadPor
        TabOrder = 16
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object edtCCaVinc: TEditFocus
        Left = 115
        Top = 143
        Width = 179
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 11
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesPlaNco: TEditFocus
        Left = 253
        Top = 74
        Width = 229
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomBan: TEditFocus
        Left = 177
        Top = 97
        Width = 430
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object grbModalidades: TGroupBox
        Left = 614
        Top = 8
        Width = 156
        Height = 125
        Caption = 'Modalidades de Recebimento'
        TabOrder = 38
        object dbeModDin: TDBCheckBox
          Left = 11
          Top = 21
          Width = 132
          Height = 16
          Caption = 'Dinheiro'
          DataField = 'POR_MODDIN'
          DataSource = dtsCadPor
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeModChv: TDBCheckBox
          Left = 11
          Top = 37
          Width = 132
          Height = 16
          Caption = 'Cheque '#224' Vista'
          DataField = 'POR_MODCHV'
          DataSource = dtsCadPor
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeModChp: TDBCheckBox
          Left = 11
          Top = 53
          Width = 132
          Height = 16
          Caption = 'Cheque '#224' Prazo'
          DataField = 'POR_MODCHP'
          DataSource = dtsCadPor
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeModCar: TDBCheckBox
          Left = 11
          Top = 69
          Width = 132
          Height = 16
          Caption = 'Cart'#227'o'
          DataField = 'POR_MODCAR'
          DataSource = dtsCadPor
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeModOrd: TDBCheckBox
          Left = 11
          Top = 85
          Width = 132
          Height = 16
          Caption = 'Ordem de Pagamento'
          DataField = 'POR_MODORD'
          DataSource = dtsCadPor
          TabOrder = 4
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeModFin: TDBCheckBox
          Left = 11
          Top = 101
          Width = 132
          Height = 16
          Caption = 'Financiamento'
          DataField = 'POR_MODFIN'
          DataSource = dtsCadPor
          TabOrder = 5
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object chkCONPOR: TDBCheckBox
        Left = 307
        Top = 322
        Width = 469
        Height = 16
        Caption = 
          'Considerar t'#237'tulos deste portador na trava de atraso m'#225'ximo do c' +
          'liente.'
        DataField = 'POR_CONPOR'
        DataSource = dtsCadPor
        TabOrder = 33
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        WordWrap = True
        OnEnter = chkBaiUtlEnter
        OnExit = chkBaiUtlExit
        OnMouseEnter = chkBaiUtlEnter
        OnMouseLeave = chkBaiUtlExit
      end
      object dbeTitPDD: TDBCheckBox
        Left = 8
        Top = 341
        Width = 285
        Height = 16
        Caption = 'Gera T'#237'tulos PDD (Provis'#227'o de Devedores Duvidosos)'
        DataField = 'POR_TITPDD'
        DataSource = dtsCadPor
        TabOrder = 23
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeBAICTF: TDBCheckBox
        Left = 307
        Top = 339
        Width = 197
        Height = 16
        Caption = 'Permitir Baixa no Contas '#225' Receber?'
        DataField = 'POR_BAICTF'
        DataSource = dtsCadPor
        TabOrder = 34
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object chkConOfx: TDBCheckBox
        Left = 307
        Top = 356
        Width = 236
        Height = 16
        Caption = 'Permitir Concilia'#231#227'o via Extrato Eletr'#244'nico?'
        DataField = 'POR_CONOFX'
        DataSource = dtsCadPor
        TabOrder = 36
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = chkConOfxClick
      end
      object chkPerAut: TDBCheckBox
        Left = 307
        Top = 375
        Width = 342
        Height = 16
        Caption = 'Permitir selecionar na tela de gera'#231#227'o de duplicatas do Autban?'
        DataField = 'POR_PERAUT'
        DataSource = dtsCadPor
        TabOrder = 37
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = chkConOfxClick
      end
      object dbchkEstCtr: TDBCheckBox
        Left = 510
        Top = 339
        Width = 203
        Height = 16
        Caption = 'Permitir Estorno no Contas '#225' Receber?'
        DataField = 'POR_ESTCTR'
        DataSource = dtsCadPor
        TabOrder = 35
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbeCodigoFornecedorFiscal: TDBEditFocus
        Tag = 99
        Left = 115
        Top = 166
        Width = 62
        Height = 22
        CharCase = ecUpperCase
        DataField = 'POR_FORFIS'
        DataSource = dtsCadPor
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 13
        OnKeyPress = dbeCodigoFornecedorFiscalKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object edtNomeFornecedorFiscal: TEditFocus
        Left = 177
        Top = 166
        Width = 430
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 39
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbChkPerCreDeb: TDBCheckBox
        Left = 8
        Top = 392
        Width = 210
        Height = 16
        Caption = 'Permitir baixa de cr'#233'dito com debito'
        DataField = 'POR_BAICCD'
        DataSource = dtsCadPor
        TabOrder = 25
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        WordWrap = True
        OnEnter = chkBaiUtlEnter
        OnExit = chkBaiUtlExit
        OnMouseEnter = chkBaiUtlEnter
        OnMouseLeave = chkBaiUtlExit
      end
    end
    object tbsEmpresas: TTabSheet
      Caption = '&2 - Empresas Acesso'
      ImageIndex = 1
      ExplicitHeight = 397
      object clbEmpCnd: TCheckListBox
        Left = 0
        Top = 0
        Width = 779
        Height = 423
        Align = alClient
        ItemHeight = 14
        TabOrder = 0
        ExplicitHeight = 380
      end
      object pnlSelEmp: TPanel
        Left = 0
        Top = 423
        Width = 779
        Height = 17
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 1
        Visible = False
        ExplicitTop = 380
        object lblLegenda: TLabel
          Left = 0
          Top = 0
          Width = 779
          Height = 17
          Align = alClient
          Alignment = taCenter
          Caption = '[F8] Marcar Todas       [F9] Desmarcar Todas'
          Color = clGray
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 237
          ExplicitHeight = 14
        end
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 552
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 524
    Top = 0
  end
  object dtsCadPor: TDataSource
    OnStateChange = dtsCadPorStateChange
    Left = 468
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpRightBottom
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 580
  end
  object popOpSele: TPopupMenu
    Left = 708
    Top = 212
    object MarcarTodos1: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = MarcarTodos1Click
    end
    object DesmarcarTodos1: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = DesmarcarTodos1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object InverterSeleo1: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = InverterSeleo1Click
    end
  end
end
