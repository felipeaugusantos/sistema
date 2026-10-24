inherited frmCalEstMin: TfrmCalEstMin
  Top = 279
  Width = 559
  Height = 614
  BorderIcons = [biSystemMenu]
  Caption = 'Calcula Estoque M'#237'nimo'
  Position = poMainFormCenter
  ExplicitWidth = 559
  ExplicitHeight = 614
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 543
    Width = 553
    Height = 26
    TabOrder = 1
    ExplicitTop = 543
    ExplicitWidth = 553
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 472
      Height = 22
      ExplicitWidth = 472
      ExplicitHeight = 22
      object btnGerar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 90
        Height = 22
        Caption = '&Gravar'
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
        TabOrder = 0
        OnClick = btnGerarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 474
      Top = 2
      Align = alRight
      ExplicitLeft = 474
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 569
    Width = 553
    TabOrder = 2
    ExplicitTop = 569
    ExplicitWidth = 553
    inherited pnlNomeForm: TPanel
      Left = 382
      ExplicitLeft = 382
    end
    inherited pnlInfo: TPanel
      Width = 382
      ExplicitWidth = 382
      object shpMultSel: TShape
        Left = 365
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 553
    Height = 543
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 21
      Top = 34
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 339
      Top = 211
      Width = 48
      Height = 14
      Caption = 'Empresas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 12
      Top = 11
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object Label19: TLabel
      Left = 47
      Top = 84
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label167: TLabel
      Left = 7
      Top = 107
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Produto:'
    end
    object Label20: TLabel
      Left = 7
      Top = 130
      Width = 73
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Compra:'
    end
    object Label21: TLabel
      Left = 10
      Top = 155
      Width = 70
      Height = 14
      Caption = 'Departamento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 40
      Top = 58
      Width = 40
      Height = 14
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 82
      Top = 31
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
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
      Left = 152
      Top = 31
      Width = 380
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pgbStatus: TProgressBar
      Left = 2
      Top = 531
      Width = 549
      Height = 10
      Align = alBottom
      Smooth = True
      TabOrder = 19
    end
    object lstEmpresas: TCheckListBox
      Left = 336
      Top = 228
      Width = 205
      Height = 219
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 18
      OnEnter = lstEmpresasEnter
      OnKeyDown = lstEmpresasKeyDown
    end
    object pgcOpcao: TcxPageControl
      Left = 9
      Top = 211
      Width = 324
      Height = 236
      ParentBackground = False
      TabOrder = 15
      Properties.ActivePage = TSCalGer
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 10
      LookAndFeel.Kind = lfOffice11
      ClientRectBottom = 236
      ClientRectRight = 324
      ClientRectTop = 20
      object TSCalGer: TcxTabSheet
        Caption = 'C'#225'lculo Geral'
        ImageIndex = 0
        object pnlCalcGeral: TPanel
          Left = 0
          Top = 0
          Width = 324
          Height = 216
          Align = alClient
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object Label2: TLabel
            Left = 7
            Top = 50
            Width = 123
            Height = 14
            Caption = 'Dias para estoque m'#237'nimo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 7
            Top = 87
            Width = 168
            Height = 14
            Caption = 'Fator para c'#225'lculo estoque m'#225'ximo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl1: TLabel
            Left = 7
            Top = 13
            Width = 150
            Height = 14
            Caption = 'Qtd. Meses p/ c'#225'lculo da m'#233'dia'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblSelMes: TLabel
            Left = 168
            Top = 30
            Width = 147
            Height = 14
            Cursor = crHandPoint
            Caption = 'Clique aqui para sel. os meses'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblSelMesClick
          end
          object edtDiaEst: TEditFocus
            Tag = 99
            Left = 7
            Top = 64
            Width = 58
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 1
            Text = '30'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtFatGer: TEditFocus
            Tag = 99
            Left = 7
            Top = 101
            Width = 58
            Height = 22
            Hint = 
              'Atualiza o estoque m'#225'ximo de acordo com'#13#10'o valor do estoque m'#237'ni' +
              'mo * fator atualiza'#231#227'o,'#13#10'Caso for zero n'#227'o atualiza o estoque m'#225 +
              'ximo...'
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 6
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Text = '1,0000'
            OnExit = edtFatGerExit
            OnKeyPress = edtFatGerKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '0.0000'
          end
          object edtQtdMes: TEditFocus
            Tag = 99
            Left = 7
            Top = 27
            Width = 58
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 0
            Text = '3'
            OnChange = edtQtdMesChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object rdgTipMed: TRadioGroup
            Left = 7
            Top = 129
            Width = 280
            Height = 68
            Caption = 'Para o c'#225'lculo da sugest'#227'o considerar:'
            Enabled = False
            ItemIndex = 0
            Items.Strings = (
              'M'#233'dia Integral (considera todos os meses)'
              'M'#233'dia Ajustada (despreza o maior e o menor m'#234's)')
            TabOrder = 3
          end
          object chkInfMes: TCheckBox
            Left = 69
            Top = 30
            Width = 97
            Height = 17
            Caption = 'Informar meses'
            TabOrder = 4
            OnClick = chkInfMesClick
          end
        end
      end
      object TSCalABC: TcxTabSheet
        Caption = 'C'#225'lculo por ABC'
        ImageIndex = 1
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnlCalcABC: TPanel
          Left = 0
          Top = 0
          Width = 324
          Height = 216
          Align = alClient
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object Label3: TLabel
            Left = 7
            Top = 68
            Width = 220
            Height = 14
            Caption = 'Dias para estoque m'#237'nimo de produtos N'#237'vel A'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 7
            Top = 93
            Width = 220
            Height = 14
            Caption = 'Dias para estoque m'#237'nimo de produtos N'#237'vel B'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 7
            Top = 118
            Width = 220
            Height = 14
            Caption = 'Dias para estoque m'#237'nimo de produtos N'#237'vel C'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 7
            Top = 143
            Width = 204
            Height = 14
            Caption = 'Fator para c'#225'lculo estoque m'#225'ximo N'#237'vel A'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl2: TLabel
            Left = 7
            Top = 19
            Width = 163
            Height = 14
            Caption = 'Qtd. Meses para c'#225'lculo da m'#233'dia'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 7
            Top = 168
            Width = 204
            Height = 14
            Caption = 'Fator para c'#225'lculo estoque m'#225'ximo N'#237'vel B'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 7
            Top = 193
            Width = 204
            Height = 14
            Caption = 'Fator para c'#225'lculo estoque m'#225'ximo N'#237'vel C'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblSelMesABC: TLabel
            Left = 132
            Top = 39
            Width = 180
            Height = 14
            Cursor = crHandPoint
            Caption = 'Clique aqui para selecionar os meses'
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lblSelMesABCClick
          end
          object edtDiaEstA: TEditFocus
            Tag = 99
            Left = 255
            Top = 64
            Width = 58
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 1
            Text = '30'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtDiaEstB: TEditFocus
            Tag = 99
            Left = 255
            Top = 89
            Width = 58
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 2
            Text = '30'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtDiaEstC: TEditFocus
            Tag = 99
            Left = 255
            Top = 114
            Width = 58
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 3
            Text = '30'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtFatA: TEditFocus
            Tag = 99
            Left = 255
            Top = 139
            Width = 58
            Height = 22
            Hint = 
              'Atualiza o estoque m'#225'ximo de acordo com'#13#10'o valor do estoque m'#237'ni' +
              'mo * fator atualiza'#231#227'o,'#13#10'Caso for zero n'#227'o atualiza o estoque m'#225 +
              'ximo...'
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 6
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            Text = '0,0000'
            OnKeyPress = edtFatGerKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '0.0000'
          end
          object edtQtdMesABC: TEditFocus
            Tag = 99
            Left = 255
            Top = 15
            Width = 58
            Height = 22
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 0
            Text = '3'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtFatB: TEditFocus
            Tag = 99
            Left = 255
            Top = 164
            Width = 58
            Height = 22
            Hint = 
              'Atualiza o estoque m'#225'ximo de acordo com'#13#10'o valor do estoque m'#237'ni' +
              'mo * fator atualiza'#231#227'o,'#13#10'Caso for zero n'#227'o atualiza o estoque m'#225 +
              'ximo...'
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 6
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            Text = '0,0000'
            OnKeyPress = edtFatGerKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '0.0000'
          end
          object edtFatC: TEditFocus
            Tag = 99
            Left = 255
            Top = 189
            Width = 58
            Height = 22
            Hint = 
              'Atualiza o estoque m'#225'ximo de acordo com'#13#10'o valor do estoque m'#237'ni' +
              'mo * fator atualiza'#231#227'o,'#13#10'Caso for zero n'#227'o atualiza o estoque m'#225 +
              'ximo...'
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 6
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            Text = '0,0000'
            OnKeyPress = edtFatGerKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '0.0000'
          end
          object chkInfMesABC: TCheckBox
            Left = 33
            Top = 39
            Width = 97
            Height = 17
            Caption = 'Informar meses'
            TabOrder = 7
            OnClick = chkInfMesABCClick
          end
        end
      end
      object TSCalXYZ: TcxTabSheet
        Caption = 'C'#225'lculo por XYZ'
        ImageIndex = 2
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label9: TLabel
          Left = 7
          Top = 68
          Width = 220
          Height = 14
          Caption = 'Dias para estoque m'#237'nimo de produtos N'#237'vel Z'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 7
          Top = 93
          Width = 221
          Height = 14
          Caption = 'Dias para estoque m'#237'nimo de produtos N'#237'vel Y'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 7
          Top = 118
          Width = 220
          Height = 14
          Caption = 'Dias para estoque m'#237'nimo de produtos N'#237'vel X'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 7
          Top = 143
          Width = 204
          Height = 14
          Caption = 'Fator para c'#225'lculo estoque m'#225'ximo N'#237'vel Z'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 7
          Top = 19
          Width = 163
          Height = 14
          Caption = 'Qtd. Meses para c'#225'lculo da m'#233'dia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 7
          Top = 168
          Width = 205
          Height = 14
          Caption = 'Fator para c'#225'lculo estoque m'#225'ximo N'#237'vel Y'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 7
          Top = 193
          Width = 204
          Height = 14
          Caption = 'Fator para c'#225'lculo estoque m'#225'ximo N'#237'vel X'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblSelMesXYZ: TLabel
          Left = 132
          Top = 39
          Width = 180
          Height = 14
          Cursor = crHandPoint
          Caption = 'Clique aqui para selecionar os meses'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lblSelMesXYZClick
        end
        object edtDiaEstZ: TEditFocus
          Tag = 99
          Left = 255
          Top = 64
          Width = 58
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          TabOrder = 1
          Text = '30'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtDiaEstY: TEditFocus
          Tag = 99
          Left = 255
          Top = 89
          Width = 58
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          TabOrder = 2
          Text = '30'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtDiaEstX: TEditFocus
          Tag = 99
          Left = 255
          Top = 114
          Width = 58
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          TabOrder = 3
          Text = '30'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtFatZ: TEditFocus
          Tag = 99
          Left = 255
          Top = 139
          Width = 58
          Height = 22
          Hint = 
            'Atualiza o estoque m'#225'ximo de acordo com'#13#10'o valor do estoque m'#237'ni' +
            'mo * fator atualiza'#231#227'o,'#13#10'Caso for zero n'#227'o atualiza o estoque m'#225 +
            'ximo...'
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 6
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Text = '0,0000'
          OnKeyPress = edtFatGerKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '0.0000'
        end
        object edtQtdMesXYZ: TEditFocus
          Tag = 99
          Left = 255
          Top = 15
          Width = 58
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 0
          Text = '3'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtFatY: TEditFocus
          Tag = 99
          Left = 255
          Top = 164
          Width = 58
          Height = 22
          Hint = 
            'Atualiza o estoque m'#225'ximo de acordo com'#13#10'o valor do estoque m'#237'ni' +
            'mo * fator atualiza'#231#227'o,'#13#10'Caso for zero n'#227'o atualiza o estoque m'#225 +
            'ximo...'
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 6
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Text = '0,0000'
          OnKeyPress = edtFatGerKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '0.0000'
        end
        object edtFatX: TEditFocus
          Tag = 99
          Left = 255
          Top = 189
          Width = 58
          Height = 22
          Hint = 
            'Atualiza o estoque m'#225'ximo de acordo com'#13#10'o valor do estoque m'#237'ni' +
            'mo * fator atualiza'#231#227'o,'#13#10'Caso for zero n'#227'o atualiza o estoque m'#225 +
            'ximo...'
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 6
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Text = '0,0000'
          OnKeyPress = edtFatGerKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '0.0000'
        end
        object chkInfMesXYZ: TCheckBox
          Left = 33
          Top = 39
          Width = 97
          Height = 17
          Caption = 'Informar meses'
          TabOrder = 7
          OnClick = chkInfMesXYZClick
        end
      end
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 82
      Top = 7
      Width = 69
      Height = 22
      CharCase = ecUpperCase
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 0
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
      Left = 152
      Top = 7
      Width = 380
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 82
      Top = 79
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 6
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
      Left = 152
      Top = 79
      Width = 380
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
    object edtPrdGru: TEditFocus
      Tag = 99
      Left = 82
      Top = 103
      Width = 69
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 8
      OnExit = edtPrdGruExit
      OnKeyPress = edtPrdGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesPrdPro: TEditFocus
      Left = 152
      Top = 103
      Width = 380
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtGruCmp: TEditFocus
      Tag = 99
      Left = 82
      Top = 127
      Width = 69
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 10
      OnExit = edtGruCmpExit
      OnKeyPress = edtGruCmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesGruCmp: TEditFocus
      Left = 152
      Top = 127
      Width = 380
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
    object edtCodDep: TEditFocus
      Tag = 99
      Left = 82
      Top = 151
      Width = 69
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 12
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
    object edtDesDep: TEditFocus
      Left = 152
      Top = 151
      Width = 380
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 82
      Top = 55
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 4
      OnExit = edtCodIteExit
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
      Left = 152
      Top = 55
      Width = 380
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkMostrarPrevia: TCheckBox
      Left = 82
      Top = 179
      Width = 214
      Height = 17
      Caption = 'Mostrar pr'#233'via das altera'#231#245'es'
      TabOrder = 14
      OnClick = chkMostrarPreviaClick
    end
    object rdgCalcEst: TRadioGroup
      Left = 7
      Top = 457
      Width = 525
      Height = 53
      ItemIndex = 0
      Items.Strings = (
        'Se resultado fracionado, arredondar Valor para Cima'
        'Se resultado fracionado, arredondar Valor para Baixo')
      TabOrder = 17
      TabStop = True
    end
    object chkCalcEst: TCheckBox
      Left = 13
      Top = 452
      Width = 489
      Height = 17
      Caption = 
        'Calcular Estoque M'#237'nimo e Estoque M'#225'ximo de Forma N'#227'o Fracionada' +
        ' (Somente Valores Inteiros)'
      Checked = True
      State = cbChecked
      TabOrder = 16
      OnClick = chkCalcEstClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 0
  end
end
