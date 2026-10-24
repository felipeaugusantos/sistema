inherited frmDigGiroEstoque: TfrmDigGiroEstoque
  Left = 255
  Top = 185
  Width = 1017
  Height = 734
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Calculo de giro de estoque'
  Position = poScreenCenter
  ExplicitTop = -157
  ExplicitWidth = 1017
  ExplicitHeight = 734
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 661
    Width = 1011
    TabOrder = 3
    ExplicitTop = 687
    ExplicitWidth = 1011
    DesignSize = (
      1011
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1007
      ExplicitWidth = 1007
    end
    inherited btnSair: TBitBtnLocked
      Left = 311
      ExplicitLeft = 311
    end
  end
  inherited pnlStatus: TPanel
    Top = 689
    Width = 1011
    TabOrder = 4
    ExplicitTop = 715
    ExplicitWidth = 1011
    inherited pnlNomeForm: TPanel
      Left = 829
      Width = 182
      ExplicitLeft = 829
      ExplicitWidth = 182
    end
    inherited pnlInfo: TPanel
      Width = 829
      ExplicitWidth = 829
    end
  end
  inherited pgcDados: TPageControl
    Width = 1011
    Height = 661
    TabOrder = 1
    Visible = False
    ExplicitWidth = 1011
    ExplicitHeight = 687
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1003
      ExplicitHeight = 655
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 661
    Width = 1011
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 687
    object btnConfirmaDados: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentFont = False
      TabOrder = 0
      OnClick = btnConfirmaDadosClick
    end
    object btnCancelaDados: TBitBtnLocked
      Left = 932
      Top = 3
      Width = 77
      Height = 22
      Caption = 'C&ancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
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
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelaClick
    end
    object mmoHelp: TMemo
      Left = 82
      Top = 3
      Width = 844
      Height = 21
      TabStop = False
      Color = clInfoBk
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      Lines.Strings = (
        
          'A sugest'#227'o, quando mais de uma empresa for selecionada, ser'#225' cal' +
          'culada individualmente por empresa e posteriormente somada na su' +
          'gest'#227'o final.')
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 1011
    Height = 661
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 687
    object pnlFiltros: TPanel
      Left = 2
      Top = 2
      Width = 1007
      Height = 295
      Align = alTop
      Caption = 'pnlFiltros'
      ParentColor = True
      TabOrder = 0
      object cxGroupBox5: TcxGroupBox
        Left = 4
        Top = 1
        Caption = 'Filtros para os Produtos:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        TabOrder = 0
        Height = 291
        Width = 597
        object lblLinGru: TLabel
          Left = 37
          Top = 40
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha / Grupo:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblCodFor: TLabel
          Left = 46
          Top = 63
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
        end
        object lblCodMar: TLabel
          Left = 72
          Top = 102
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Marca:'
        end
        object lblRefere: TLabel
          Left = 49
          Top = 216
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Refer'#234'ncia:'
        end
        object lblCodCmp: TLabel
          Left = 48
          Top = 17
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Comprador:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblPrdGru: TLabel
          Left = 16
          Top = 125
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = 'Grupo de Produto:'
        end
        object lblCodUni: TLabel
          Left = 335
          Top = 239
          Width = 24
          Height = 14
          Caption = 'Unid:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblCodDep: TLabel
          Left = 35
          Top = 171
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Departamento:'
        end
        object lblAcoObj: TLabel
          Left = 214
          Top = 216
          Width = 73
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acordo de Obj:'
        end
        object lblTitDig: TLabel
          Left = 316
          Top = 17
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Digitador:'
        end
        object lblLocIni: TLabel
          Left = 400
          Top = 234
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = 'Loc. F'#237'sica Inicial'
        end
        object lblLocFin: TLabel
          Left = 404
          Top = 259
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Loc. F'#237'sica Final'
          Enabled = False
        end
        object lblLocIni2: TLabel
          Left = 403
          Top = 245
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'da Emp. Origem:'
        end
        object lblLocFin2: TLabel
          Left = 403
          Top = 270
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'da Emp. Origem:'
          Enabled = False
        end
        object lblGruCmp: TLabel
          Left = 16
          Top = 148
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = 'Grupo de Compra:'
        end
        object lblDesIte: TLabel
          Left = 54
          Top = 194
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o:'
        end
        object lblSitPro: TLabel
          Left = 5
          Top = 239
          Width = 100
          Height = 14
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o do Produto:'
        end
        object rdgSalEmpDes: TRadioGroup
          Left = 440
          Top = 125
          Width = 148
          Height = 103
          Caption = 'Saldo disp. empr. destino'
          ItemIndex = 3
          Items.Strings = (
            'Menor ou Igual a zero'
            'Abaixo do m'#237'nimo'
            'Acima ou igual ao m'#237'nimo'
            'Todos')
          TabOrder = 17
        end
        object edtDesPrdGru: TEditFocus
          Left = 165
          Top = 121
          Width = 270
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 19
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object mskLinGru: TMaskEditFocus
          Tag = 99
          Left = 108
          Top = 36
          Width = 57
          Height = 22
          EditMask = '999.999;0;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          TabOrder = 2
          Text = ''
          OnExit = mskLinGruExit
          OnKeyPress = mskLinGruKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesGru: TEditFocus
          Left = 165
          Top = 36
          Width = 270
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 20
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodFor: TEditFocus
          Tag = 99
          Left = 108
          Top = 59
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 3
          OnEnter = edtCodForEnter
          OnExit = edtCodForExit
          OnKeyPress = edtCodForKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNomFor: TEditFocus
          Left = 165
          Top = 59
          Width = 270
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 21
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodMar: TEditFocus
          Tag = 99
          Left = 108
          Top = 98
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 5
          OnExit = edtCodMarExit
          OnKeyPress = edtCodMarKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesMar: TEditFocus
          Left = 165
          Top = 98
          Width = 270
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 22
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRefere: TEditFocus
          Left = 108
          Top = 213
          Width = 104
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodCmp: TEditFocus
          Tag = 99
          Left = 108
          Top = 13
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ParentFont = False
          PasswordChar = '*'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 10
          TipoTexto = ttAlfanumerico
        end
        object edtNomCmp: TEditFocus
          Left = 165
          Top = 13
          Width = 146
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 23
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPrdGru: TEditFocus
          Tag = 99
          Left = 108
          Top = 121
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 6
          OnExit = edtPrdGruExit
          OnKeyPress = edtPrdGruKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtUnidade: TEditFocus
          Tag = 99
          Left = 360
          Top = 236
          Width = 35
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          TabOrder = 13
          OnExit = edtUnidadeExit
          OnKeyPress = edtUnidadeKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
        object edtCodDep: TEditFocus
          Tag = 99
          Left = 108
          Top = 167
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 8
          OnExit = edtCodDepExit
          OnKeyPress = edtCodDepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesCodDep: TEditFocus
          Left = 165
          Top = 167
          Width = 270
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
        object edtAcoObj: TEditFocus
          Tag = 99
          Left = 288
          Top = 213
          Width = 147
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttAlfanumerico
        end
        object rdgLocfis: TRadioGroup
          Left = 440
          Top = 40
          Width = 148
          Height = 79
          Caption = 'Localiza'#231#227'o f'#237'sica:'
          ItemIndex = 2
          Items.Strings = (
            'Com localiza'#231#227'o'
            'Sem localiza'#231#227'o'
            'Todos')
          TabOrder = 16
        end
        object rdgSaldos: TRadioGroup
          Left = 440
          Top = 123
          Width = 148
          Height = 75
          Caption = 'Saldo'
          ItemIndex = 2
          Items.Strings = (
            'Zerado'
            'Positivo'
            'Negativo'
            'Todos')
          TabOrder = 18
        end
        object edtCodDig: TEditFocus
          Tag = 99
          Left = 364
          Top = 13
          Width = 49
          Height = 22
          Alignment = taLeftJustify
          AutoSize = False
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 40
          PasswordChar = '*'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomDig: TEditFocus
          Left = 414
          Top = 13
          Width = 174
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 25
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLocIni: TEditFocus
          Tag = 99
          Left = 484
          Top = 236
          Width = 103
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 14
          OnKeyPress = edtLocIniKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtLocFin: TEditFocus
          Tag = 99
          Left = 484
          Top = 260
          Width = 103
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 15
          OnKeyPress = edtLocFinKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtGruCmp: TEditFocus
          Tag = 99
          Left = 108
          Top = 144
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 7
          OnExit = edtGruCmpExit
          OnKeyPress = edtGruCmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesGruCmp: TEditFocus
          Left = 165
          Top = 144
          Width = 270
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 26
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesIte: TEditFocus
          Tag = 99
          Left = 108
          Top = 190
          Width = 327
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesSitPro: TEditFocus
          Left = 165
          Top = 236
          Width = 168
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 27
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodSit: TEditFocus
          Tag = 99
          Left = 108
          Top = 236
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 12
          OnExit = edtCodSitExit
          OnKeyPress = edtCodSitKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object chkAnalisaITEFOR: TCheckBox
          Left = 107
          Top = 82
          Width = 331
          Height = 15
          Caption = 'Analisar todos os itens do fornecedor, independente do principal'
          Enabled = False
          TabOrder = 4
        end
        object pnlDiasVendas: TPanel
          Left = 3
          Top = 260
          Width = 361
          Height = 23
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 28
          object Label1: TLabel
            Left = 7
            Top = 3
            Width = 274
            Height = 14
            Caption = 'Carregar apenas itens com venda nos '#250'ltimos          dias.'
            WordWrap = True
          end
          object edtDias: TEditFocus
            Left = 230
            Top = 0
            Width = 25
            Height = 22
            Alignment = taRightJustify
            TabOrder = 0
            Text = '0'
            OnExit = edtDiasExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
        end
      end
      object cxGroupBox3: TcxGroupBox
        Left = 607
        Top = 1
        Caption = 'Selecione as Empresas para o Giro:'
        ParentFont = False
        Style.BorderColor = clBlack
        Style.BorderStyle = ebsUltraFlat
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 14
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.LookAndFeel.NativeStyle = False
        Style.Shadow = True
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleDisabled.LookAndFeel.NativeStyle = False
        TabOrder = 1
        Height = 291
        Width = 398
        object lblOpSele: TLabel
          Left = 19
          Top = 262
          Width = 95
          Height = 14
          Cursor = crHandPoint
          Caption = 'Op'#231#245'es de Sele'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lblOpSeleClick
        end
        object cxGrid: TcxGrid
          Left = 7
          Top = 17
          Width = 381
          Height = 243
          TabOrder = 0
          LookAndFeel.Kind = lfOffice11
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxvEmpresas: TcxGridDBTableView
            OnKeyDown = cxvEmpresasKeyDown
            Navigator.Buttons.CustomButtons = <>
            FilterBox.CustomizeDialog = False
            DataController.DataSource = dtsEmpSel
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object cxvEmpresasCODEMP: TcxGridDBColumn
              Caption = 'C'#243'd.'
              DataBinding.FieldName = 'CODEMP'
              Options.Editing = False
              Options.Focusing = False
              Width = 39
            end
            object cxvEmpresasDESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'DESCRI'
              Options.Editing = False
              Options.Focusing = False
              Width = 193
            end
            object cxvEmpresasMARDES: TcxGridDBColumn
              Caption = 'Emp.Calcul.'
              DataBinding.FieldName = 'MARDES'
              RepositoryItem = chkMarDes
              HeaderAlignmentHorz = taCenter
              Options.Filtering = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Width = 60
            end
            object cxvEmpresasEMPVIS: TcxGridDBColumn
              Caption = 'Emp.Visual.'
              DataBinding.FieldName = 'EMPVIS'
              RepositoryItem = chkMarDes
              HeaderAlignmentHorz = taCenter
              Width = 60
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = cxvEmpresas
          end
        end
      end
    end
    object pgcGiro: TPageControl
      Left = 2
      Top = 297
      Width = 1007
      Height = 362
      ActivePage = tbsCalGir
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 1
      TabStop = False
      ExplicitHeight = 367
      object tbsCalSug: TTabSheet
        Caption = '&1 - C'#225'lculo da Quantidade de Sugest'#227'o:'
        ExplicitHeight = 335
        object lblImpReq: TLabel
          Left = 581
          Top = 277
          Width = 271
          Height = 14
          Caption = '* Requisi'#231#245'es filtradas pelos t'#237'tulos destacados em azul.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object cxgApresentacao: TcxGroupBox
          Left = 4
          Top = 265
          Caption = 'Apresenta'#231#227'o:'
          ParentFont = False
          Style.BorderColor = clBlack
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.LookAndFeel.NativeStyle = False
          Style.Shadow = True
          Style.IsFontAssigned = True
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleDisabled.LookAndFeel.NativeStyle = False
          TabOrder = 0
          Height = 68
          Width = 360
          object chkCarIte: TCheckBox
            Left = 166
            Top = 27
            Width = 135
            Height = 15
            Caption = 'Carregar itens no grid'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object rdgOrdem: TRadioGroup
            Tag = 99
            Left = 12
            Top = 13
            Width = 148
            Height = 47
            Caption = 'Ordem:'
            ItemIndex = 0
            Items.Strings = (
              'Descri'#231#227'o'
              'Marca+Descri'#231#227'o')
            TabOrder = 0
            OnClick = rdgOrdemClick
          end
          object chkExiApli: TCheckBox
            Tag = 99
            Left = 166
            Top = 42
            Width = 157
            Height = 16
            Caption = 'Exibir Aplica'#231#227'o do Produto'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
        end
        object chkImpReq: TCheckBox
          Left = 370
          Top = 277
          Width = 206
          Height = 14
          Caption = 'Importar requisi'#231#245'es automaticamente.'
          TabOrder = 1
          OnClick = chkImpReqClick
        end
        object chkSpoTra: TCheckBox
          Left = 370
          Top = 310
          Width = 424
          Height = 14
          Caption = 
            'Calcular Transfer'#234'ncia de Saldo de Estoque em Excesso ( Spool de' +
            ' Transfer'#234'ncia )'
          TabOrder = 2
        end
        object chkLimReq: TCheckBox
          Left = 370
          Top = 294
          Width = 407
          Height = 14
          Caption = 'Limitar Empresas na Importa'#231#227'o das Requisi'#231#245'es de Compras'
          Enabled = False
          TabOrder = 3
        end
      end
      object tbsCalGir: TTabSheet
        Caption = '&2 - C'#225'lculo do Giro:'
        ImageIndex = 1
        ExplicitHeight = 335
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 696
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 640
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 904
    Top = 64
  end
  object cxEditRepository1: TcxEditRepository
    Left = 896
    Top = 264
    PixelsPerInch = 96
    object chkMarDes: TcxEditRepositoryCheckBoxItem
      Properties.ImmediatePost = True
      Properties.ValueChecked = 'S'
      Properties.ValueUnchecked = 'N'
    end
  end
  object popOpSele: TPopupMenu
    Left = 736
    Top = 48
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
  object cxGridPopupMenu1: TcxGridPopupMenu
    PopupMenus = <>
    Left = 778
    Top = 258
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 960
    Top = 264
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clMoneyGreen
      TextColor = clBlack
    end
  end
  object dtsEmpSel: TDataSource
    Left = 624
    Top = 67
  end
end
