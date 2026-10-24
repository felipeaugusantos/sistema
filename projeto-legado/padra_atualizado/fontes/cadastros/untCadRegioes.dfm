inherited frmCadRegioes: TfrmCadRegioes
  Left = 408
  Top = 396
  Width = 649
  Height = 550
  Caption = 'Cadastro de Regi'#227'o'
  ExplicitWidth = 649
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 480
    Width = 643
    Height = 25
    ExplicitTop = 371
    ExplicitWidth = 643
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 572
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 572
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 66
        ExplicitWidth = 66
      end
      inherited btnGravar: TBitBtnLocked
        Left = 66
        Width = 71
        ExplicitLeft = 66
        ExplicitWidth = 71
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 137
        Width = 66
        ExplicitLeft = 137
        ExplicitWidth = 66
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 203
        Width = 66
        ExplicitLeft = 203
        ExplicitWidth = 66
      end
      inherited btnCancela: TBitBtnLocked
        Left = 269
        Width = 71
        ExplicitLeft = 269
        ExplicitWidth = 71
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 340
        Width = 73
        ExplicitLeft = 340
        ExplicitWidth = 73
      end
      object btnHorarios: TBitBtnLocked
        Left = 413
        Top = 0
        Width = 75
        Height = 20
        Caption = '[ F3 ] Hor'#225'rios'
        Enabled = False
        TabOrder = 6
        OnClick = btnHorariosClick
      end
      object btnVincularCep: TBitBtnLocked
        Left = 488
        Top = 0
        Width = 72
        Height = 20
        Caption = '&Vincular CEP'
        TabOrder = 7
        Visible = False
        OnClick = btnVincularCepClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 574
      Width = 67
      Height = 21
      Align = alRight
      ExplicitLeft = 574
      ExplicitWidth = 67
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 505
    Width = 643
    ExplicitTop = 396
    ExplicitWidth = 643
    inherited pnlNomeForm: TPanel
      Left = 452
      Width = 191
      ExplicitLeft = 452
      ExplicitWidth = 191
    end
    inherited pnlInfo: TPanel
      Width = 452
      ExplicitWidth = 452
    end
  end
  inherited pgcDados: TPageControl
    Width = 643
    Height = 480
    ExplicitWidth = 643
    ExplicitHeight = 371
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 635
      ExplicitHeight = 339
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 643
    Height = 480
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 371
    object rdgTaxEnt: TDBRadioGroup
      Tag = 99
      Left = 1
      Top = 169
      Width = 641
      Height = 50
      Align = alTop
      Caption = 'Cobrar taxa de entrega para clientes desta regi'#227'o'
      Columns = 2
      DataField = 'REG_COBTAX'
      DataSource = dtsCadReg
      Items.Strings = (
        'Para cada entrega, individualmente.'
        'Na primeira venda do cliente no dia.')
      TabOrder = 1
      TabStop = True
      Values.Strings = (
        'I'
        'P')
      OnEnter = rdgTaxEntEnter
    end
    object grbObservacao: TGroupBox
      Left = 1
      Top = 327
      Width = 641
      Height = 152
      Align = alClient
      Caption = 'Observa'#231#227'o'
      TabOrder = 2
      ExplicitTop = 275
      ExplicitHeight = 151
      object memObservacao: TDBMemoFocus
        Tag = 99
        Left = 2
        Top = 16
        Width = 637
        Height = 134
        Align = alClient
        DataField = 'REG_OBSERV'
        DataSource = dtsCadReg
        ScrollBars = ssVertical
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
        ExplicitHeight = 133
      end
    end
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 641
      Height = 168
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label2: TLabel
        Left = 30
        Top = 42
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object Label1: TLabel
        Left = 46
        Top = 17
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object lbl1: TLabel
        Left = 7
        Top = 65
        Width = 75
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vlr. M'#237'nimo Fat.:'
      end
      object dbeDesReg: TDBEditFocus
        Tag = 99
        Left = 85
        Top = 37
        Width = 412
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REG_DESREG'
        DataSource = dtsCadReg
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodReg: TDBEditFocus
        Tag = 99
        Left = 85
        Top = 13
        Width = 44
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REG_CODREG'
        DataSource = dtsCadReg
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeValMin: TDBEditFocus
        Tag = 99
        Left = 85
        Top = 61
        Width = 100
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REG_MINFAT'
        DataSource = dtsCadReg
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object gpb1: TGroupBox
        Left = 0
        Top = 92
        Width = 641
        Height = 76
        Align = alBottom
        Caption = 'Percentual de Comiss'#227'o'
        TabOrder = 3
        object lbl3: TLabel
          Left = 13
          Top = 24
          Width = 86
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vendedor Interno:'
        end
        object lbl4: TLabel
          Left = 193
          Top = 24
          Width = 137
          Height = 14
          Alignment = taRightJustify
          Caption = 'Representante Externo Loja:'
        end
        object lbl2: TLabel
          Left = 159
          Top = 49
          Width = 171
          Height = 14
          Alignment = taRightJustify
          Caption = 'Representante Externo Distribuidor:'
        end
        object lbl5: TLabel
          Left = 63
          Top = 49
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Outros:'
        end
        object lblComMot: TLabel
          Left = 449
          Top = 24
          Width = 105
          Height = 14
          Alignment = taRightJustify
          Caption = 'Motorista (Romaneio):'
        end
        object dbeComInt: TDBEditFocus
          Tag = 99
          Left = 102
          Top = 21
          Width = 45
          Height = 22
          CharCase = ecUpperCase
          DataField = 'REG_COMINT'
          DataSource = dtsCadReg
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeComExt: TDBEditFocus
          Tag = 99
          Left = 333
          Top = 21
          Width = 45
          Height = 22
          CharCase = ecUpperCase
          DataField = 'REG_COMEXT'
          DataSource = dtsCadReg
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeComDis: TDBEditFocus
          Tag = 99
          Left = 333
          Top = 46
          Width = 45
          Height = 22
          CharCase = ecUpperCase
          DataField = 'REG_COMDIS'
          DataSource = dtsCadReg
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeComOut: TDBEditFocus
          Tag = 99
          Left = 102
          Top = 46
          Width = 45
          Height = 22
          CharCase = ecUpperCase
          DataField = 'REG_COMOUT'
          DataSource = dtsCadReg
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeComMot: TDBEditFocus
          Tag = 99
          Left = 557
          Top = 21
          Width = 45
          Height = 22
          CharCase = ecUpperCase
          DataField = 'REG_COMMOT'
          DataSource = dtsCadReg
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object gpbDiaFatEnt: TGroupBox
      Left = 1
      Top = 219
      Width = 641
      Height = 108
      Align = alTop
      Caption = 'Dias fixos da semana para faturamento e entrega'
      TabOrder = 3
      object lblDiaFat: TLabel
        Left = 13
        Top = 28
        Width = 197
        Height = 14
        Caption = 'Dia(s) Fixo(s) Semana (FATURAMENTO):'
      end
      object lblDiaEnt: TLabel
        Left = 40
        Top = 71
        Width = 170
        Height = 14
        Caption = 'Dia(s) Fixo(s) Semana (ENTREGA):'
      end
      object chkListDiasFat: TCheckListBox
        Left = 213
        Top = 16
        Width = 418
        Height = 41
        Columns = 4
        Enabled = False
        ItemHeight = 14
        Items.Strings = (
          'domingo'
          'segunda-feira'
          'ter'#231'a-feira'
          'quarta-feira'
          'quinta-feira'
          'sexta-feira'
          's'#225'bado')
        TabOrder = 0
      end
      object chkListDiasEnt: TCheckListBox
        Left = 213
        Top = 59
        Width = 418
        Height = 41
        Columns = 4
        Enabled = False
        ItemHeight = 14
        Items.Strings = (
          'domingo'
          'segunda-feira'
          'ter'#231'a-feira'
          'quarta-feira'
          'quinta-feira'
          'sexta-feira'
          's'#225'bado')
        TabOrder = 1
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 368
    Top = 8
  end
  object dtsCadReg: TDataSource
    OnStateChange = dtsCadRegStateChange
    Left = 560
    Top = 72
  end
end
