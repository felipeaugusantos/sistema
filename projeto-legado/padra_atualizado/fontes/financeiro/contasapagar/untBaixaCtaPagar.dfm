inherited frmBaixaCtaPagar: TfrmBaixaCtaPagar
  Left = 163
  Top = 141
  Width = 1147
  Height = 700
  Caption = 'Baixa de Contas a Pagar'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnPaint = nil
  ExplicitWidth = 1147
  ExplicitHeight = 700
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 610
    Width = 1141
    TabOrder = 7
    ExplicitTop = 610
    ExplicitWidth = 1141
    DesignSize = (
      1141
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1137
      ExplicitWidth = 1137
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 655
    Width = 1141
    ExplicitTop = 655
    ExplicitWidth = 1141
    inherited pnlNomeForm: TPanel
      Left = 987
      Width = 154
      ExplicitLeft = 987
      ExplicitWidth = 154
    end
    inherited pnlInfo: TPanel
      Width = 987
      ExplicitWidth = 987
      object shpMultSel: TShape
        Left = 971
        Top = 2
        Width = 14
        Height = 12
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 843
      end
    end
  end
  inherited pgcDados: TPageControl
    Top = 197
    Width = 1141
    Height = 413
    Visible = False
    ExplicitTop = 197
    ExplicitWidth = 1141
    ExplicitHeight = 413
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1133
      ExplicitHeight = 381
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1141
    Height = 122
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 53
      Top = 12
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object lblCodEmp: TLabel
      Left = 67
      Top = 78
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object Label24: TLabel
      Left = 68
      Top = 100
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 117
      Top = 7
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
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
      Left = 190
      Top = 7
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtNomEmp: TEditFocus
      Left = 190
      Top = 76
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 117
      Top = 76
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 7
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object chkLimFil: TCheckBox
      Left = 509
      Top = 8
      Width = 157
      Height = 17
      Caption = 'Limpar filtros ap'#243's consulta'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object edtDesPor: TEditFocus
      Left = 190
      Top = 99
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 117
      Top = 99
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 9
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object rdgVeioBo: TRadioGroup
      Left = 509
      Top = 79
      Width = 228
      Height = 38
      Caption = 'Veio Boleto?'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 11
    end
    object rdgLiberados: TRadioGroup
      Left = 509
      Top = 48
      Width = 228
      Height = 31
      Caption = 'T'#237'tulos liberados'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 6
      Visible = False
    end
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = 23
      Top = 53
      Width = 486
      Height = 22
      TabOrder = 5
      ExplicitLeft = 23
      ExplicitTop = 53
      ExplicitWidth = 486
      inherited lblEventos: TLabel
        Left = 2
        Width = 87
        Height = 14
        ExplicitLeft = 2
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Width = 72
        Height = 22
        OnExit = fraCentroCustoedtCodEveExit
        ExplicitWidth = 72
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 167
        Width = 313
        Height = 22
        Enabled = True
        ExplicitLeft = 167
        ExplicitWidth = 313
        ExplicitHeight = 22
      end
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 25
      Top = 30
      Width = 483
      Height = 22
      TabOrder = 3
      ExplicitLeft = 25
      ExplicitTop = 30
      ExplicitWidth = 483
      inherited lblPlaContas: TLabel
        Left = 11
        Width = 81
        Height = 14
        ExplicitLeft = 11
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 165
        Width = 313
        Height = 22
        ExplicitLeft = 165
        ExplicitWidth = 313
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 92
        Width = 72
        Height = 22
        OnExit = fraPlanoDeContasMskCodCtaExit
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 92
        ExplicitWidth = 72
        ExplicitHeight = 22
      end
    end
    object chkFiltrarFiliais: TCheckBox
      Left = 509
      Top = 28
      Width = 160
      Height = 17
      Caption = 'Filtrar duplicatas das filiais?'
      Enabled = False
      TabOrder = 4
      OnExit = chkFiltrarFiliaisExit
    end
  end
  object pnlAux1: TPanel [4]
    Left = 0
    Top = 197
    Width = 1141
    Height = 413
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 5
    object pnlTotais: TPanel
      Left = 0
      Top = 216
      Width = 1141
      Height = 197
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label7: TLabel
        Left = 388
        Top = 62
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pl. Contas:'
      end
      object Label12: TLabel
        Left = 370
        Top = 15
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dta. Cadastro:'
      end
      object Label14: TLabel
        Left = 394
        Top = 135
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object Label8: TLabel
        Left = 411
        Top = 112
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'S'#233'rie:'
      end
      object Label13: TLabel
        Left = 389
        Top = 39
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ctr. Custo:'
      end
      object Label20: TLabel
        Left = 392
        Top = 89
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Caption = 'Doc. Ant.:'
      end
      object lblTotVendor: TLabel
        Left = 645
        Top = 112
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tot. Ven:'
      end
      object Label35: TLabel
        Left = 523
        Top = 15
        Width = 65
        Height = 14
        Alignment = taRightJustify
        Caption = 'Compet'#234'ncia:'
      end
      object Label4: TLabel
        Left = 669
        Top = 15
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Caption = 'Previs'#227'o?:'
      end
      object edtCodCtaBai: TEditFocus
        Left = 442
        Top = 59
        Width = 75
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtDesCtaBai: TEditFocus
        Left = 519
        Top = 59
        Width = 242
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtDtaCad: TEditFocus
        Left = 442
        Top = 11
        Width = 75
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtSerie: TEditFocus
        Left = 442
        Top = 107
        Width = 75
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtCodEveBai: TEditFocus
        Left = 442
        Top = 35
        Width = 75
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtDesEveBai: TEditFocus
        Left = 519
        Top = 35
        Width = 242
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object pnlInformativos: TPanel
        Left = 1009
        Top = 2
        Width = 130
        Height = 193
        Align = alRight
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 11
        object Label16: TLabel
          Left = 2
          Top = 2
          Width = 126
          Height = 12
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'INFORMATIVO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 120
        end
        object Label17: TLabel
          Left = 28
          Top = 76
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Juros:'
        end
        object Label19: TLabel
          Left = 9
          Top = 122
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto:'
        end
        object lblVendorTotal: TLabel
          Left = 20
          Top = 30
          Width = 38
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vendor:'
        end
        object Label33: TLabel
          Left = 2
          Top = 53
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Outras Ent.:'
        end
        object lblMulSujTotal: TLabel
          Left = 30
          Top = 99
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Multa:'
        end
        object edtJurosTotal: TEditFocus
          Left = 60
          Top = 72
          Width = 61
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtDescontoTotal: TEditFocus
          Left = 60
          Top = 118
          Width = 61
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtVendorTotal: TEditFocus
          Left = 60
          Top = 26
          Width = 61
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtOutrasEntidades: TEditFocus
          Left = 60
          Top = 49
          Width = 61
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtMultaTotal: TEditFocus
          Left = 60
          Top = 95
          Width = 61
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object edtCodVel: TEditFocus
        Left = 442
        Top = 83
        Width = 75
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotVendor: TEditFocus
        Left = 688
        Top = 107
        Width = 73
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtHistor: TMemoFocus
        Left = 442
        Top = 131
        Width = 319
        Height = 60
        TabStop = False
        Color = 16768952
        ReadOnly = True
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object pnlCTREmAberto: TPanel
        Left = 841
        Top = 2
        Width = 168
        Height = 193
        Margins.Left = 10
        Margins.Right = 10
        Align = alRight
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 12
        object Label27: TLabel
          Left = 2
          Top = 2
          Width = 164
          Height = 12
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'EM ABERTO (C.RECEBER)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 120
        end
        object Label29: TLabel
          Left = 30
          Top = 53
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vencido:'
        end
        object Label30: TLabel
          Left = 29
          Top = 76
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cr'#233'ditos:'
        end
        object Label31: TLabel
          Left = 25
          Top = 30
          Width = 47
          Height = 14
          Alignment = taRightJustify
          Caption = 'A vencer:'
        end
        object Label32: TLabel
          Left = 33
          Top = 99
          Width = 39
          Height = 14
          Alignment = taRightJustify
          Caption = 'TOTAL:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtEmAbertoVenc: TEditFocus
          Left = 77
          Top = 49
          Width = 76
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtEmAbertoCred: TEditFocus
          Left = 77
          Top = 72
          Width = 76
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtEmAbertoAVenc: TEditFocus
          Left = 77
          Top = 25
          Width = 76
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtEmAbertoTotal: TEditFocus
          Left = 77
          Top = 95
          Width = 76
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
      object edtOutEnt: TEditFocus
        Left = 767
        Top = 131
        Width = 71
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 13
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object gpbGeral: TGroupBox
        Left = 4
        Top = 6
        Width = 350
        Height = 85
        Caption = ' Geral '
        TabOrder = 14
        object Label6: TLabel
          Left = 31
          Top = 16
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Qtd. Tot. Dup.:'
        end
        object Label21: TLabel
          Left = 218
          Top = 16
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total Dup.:'
        end
        object Label5: TLabel
          Left = 30
          Top = 41
          Width = 69
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tot. Desconto:'
        end
        object Label18: TLabel
          Left = 218
          Top = 41
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tot. Juros:'
        end
        object Label10: TLabel
          Left = 43
          Top = 63
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total Multa: '
        end
        object edtQtdDuplicatas: TEditFocus
          Left = 100
          Top = 12
          Width = 69
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtValorTotal: TEditFocus
          Left = 269
          Top = 13
          Width = 71
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtTotDesconto: TEditFocus
          Left = 100
          Top = 35
          Width = 69
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtTotJuros: TEditFocus
          Left = 269
          Top = 36
          Width = 71
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtTotMulta: TEditFocus
          Left = 100
          Top = 58
          Width = 69
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object gpbSelecionadas: TGroupBox
        Left = 4
        Top = 92
        Width = 350
        Height = 40
        Caption = ' Selecionadas '
        TabOrder = 15
        object Label9: TLabel
          Left = 5
          Top = 16
          Width = 93
          Height = 14
          Alignment = taRightJustify
          Caption = 'Qtd. Dup. Pagando:'
        end
        object Label23: TLabel
          Left = 224
          Top = 16
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pagando:'
        end
        object edtQtdSelecionadas: TEditFocus
          Left = 100
          Top = 12
          Width = 69
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtTotalPago: TEditFocus
          Left = 270
          Top = 12
          Width = 71
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
      end
      object GroupBox1: TGroupBox
        Left = 4
        Top = 133
        Width = 350
        Height = 59
        Caption = ' Filtradas '
        TabOrder = 16
        object Label3: TLabel
          Left = 25
          Top = 14
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'Qtd. Dup. Filtro:'
        end
        object Label22: TLabel
          Left = 21
          Top = 38
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tot. Vlr. Original:'
        end
        object Label28: TLabel
          Left = 187
          Top = 38
          Width = 82
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tot Vlr. Corrigido:'
        end
        object edtQtdDulSel: TEditFocus
          Left = 100
          Top = 11
          Width = 69
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtTotVlrOrg: TEditFocus
          Left = 100
          Top = 34
          Width = 69
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtTotVlrCorr: TEditFocus
          Left = 270
          Top = 34
          Width = 71
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
      end
      object edtCompet: TEditFocus
        Left = 591
        Top = 11
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPreVis: TEditFocus
        Left = 723
        Top = 11
        Width = 38
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
    end
    object dbgDuplicatas: TcxGrid
      Left = 0
      Top = 0
      Width = 1141
      Height = 216
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object dbgDuplicatasView: TcxGridDBTableView
        OnDblClick = dbgDuplicatasViewDblClick
        OnKeyDown = dbgDuplicatasViewKeyDown
        OnMouseDown = dbgDuplicatasViewMouseDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = dbgDuplicatasViewCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '###,###,##0.00'
            Kind = skSum
            FieldName = 'CTP_GRVORI'
            Column = dbgDuplicatasCTP_VALANT
          end
          item
            Format = '###,###,##0.00'
            Kind = skSum
            FieldName = 'TOTDUP'
            Column = dbgDuplicatasTOTDUP
          end>
        DataController.Summary.SummaryGroups = <>
        DataController.Summary.OnAfterSummary = dbgDuplicatasViewDataControllerSummaryAfterSummary
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
        OptionsView.GroupByBox = False
        object dbgDuplicatasCTP_NUMDUP: TcxGridDBColumn
          Caption = 'Duplicata'
          DataBinding.FieldName = 'CTP_NUMDUP'
          Width = 92
        end
        object dbgDuplicatasCTP_CODEMP: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'CTP_CODEMP'
          Width = 31
        end
        object dbgDuplicatasCTP_CODFOR: TcxGridDBColumn
          Caption = 'Cod. Forn.'
          DataBinding.FieldName = 'CTP_CODFOR'
          Width = 55
        end
        object dbgDuplicatasFOR_NOMFOR: TcxGridDBColumn
          Caption = 'Nom. Forn.'
          DataBinding.FieldName = 'FOR_NOMFOR'
          Width = 165
        end
        object dbgDuplicatasCTP_CODPOR: TcxGridDBColumn
          Caption = 'Portador'
          DataBinding.FieldName = 'CTP_NOMPOR'
          Width = 179
        end
        object dbgDuplicatasCTP_DTACAD: TcxGridDBColumn
          Caption = 'Cadastro'
          DataBinding.FieldName = 'CTP_DTACAD'
          HeaderAlignmentHorz = taCenter
          Width = 65
        end
        object dbgDuplicatasCTP_DTAVEN: TcxGridDBColumn
          Caption = 'Vencimento'
          DataBinding.FieldName = 'CTP_DTAVEN'
          HeaderAlignmentHorz = taCenter
          Width = 70
        end
        object dbgDuplicatasCTP_USACHQ: TcxGridDBColumn
          Caption = 'Cheque?'
          DataBinding.FieldName = 'CTP_USACHQ'
          Width = 53
        end
        object dbgDuplicatasCTP_VEIOBO: TcxGridDBColumn
          Caption = 'Veio Boleto?'
          DataBinding.FieldName = 'CTP_VEIOBO'
          Width = 66
        end
        object dbgDuplicatasCTP_VEIONF: TcxGridDBColumn
          Caption = 'Veio NF?'
          DataBinding.FieldName = 'CTP_VEIONF'
          Width = 66
        end
        object dbgDuplicatasPREVISAO: TcxGridDBColumn
          Caption = 'Previs'#227'o?'
          DataBinding.FieldName = 'PREVISAO'
          Width = 66
        end
        object dbgDuplicatasCTP_DESSUJ: TcxGridDBColumn
          Caption = 'Desconto'
          DataBinding.FieldName = 'CTP_DESSUJ'
          HeaderAlignmentHorz = taRightJustify
          Width = 58
        end
        object dbgDuplicatasCTP_JURSUJ: TcxGridDBColumn
          Caption = 'Juros'
          DataBinding.FieldName = 'CTP_JURSUJ'
          HeaderAlignmentHorz = taRightJustify
          Width = 55
        end
        object dbgDuplicatasCTP_MULSUJ: TcxGridDBColumn
          Caption = 'Multa'
          DataBinding.FieldName = 'CTP_MULSUJ'
          HeaderAlignmentHorz = taRightJustify
          Width = 55
        end
        object dbgDuplicatasViewCTP_OUTENT: TcxGridDBColumn
          Caption = 'Outras Ent.'
          DataBinding.FieldName = 'CTP_OUTENT'
          HeaderAlignmentHorz = taRightJustify
          Width = 66
        end
        object dbgDuplicatasCTP_VENDOR: TcxGridDBColumn
          Caption = 'Vendor'
          DataBinding.FieldName = 'CTP_VENDOR'
          HeaderAlignmentHorz = taRightJustify
          Width = 56
        end
        object dbgDuplicatasCTP_VALANT: TcxGridDBColumn
          Caption = 'Valor Original'
          DataBinding.FieldName = 'CTP_GRVORI'
          HeaderAlignmentHorz = taRightJustify
          Width = 78
        end
        object dbgDuplicatasTOTDUP: TcxGridDBColumn
          Caption = 'Valor Corrigido'
          DataBinding.FieldName = 'TOTDUP'
          HeaderAlignmentHorz = taRightJustify
          Width = 78
        end
        object dbgDuplicatasCTP_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'CTP_MARDES'
          Visible = False
        end
        object dbgDuplicatasCTP_SERIE_AG: TcxGridDBColumn
          DataBinding.FieldName = 'AGRSER'
          Visible = False
        end
        object dbgDuplicatasCTP_NUMDUP_AG: TcxGridDBColumn
          DataBinding.FieldName = 'NRODUP'
          Visible = False
        end
        object dbgDuplicatasCTP_CODEMP_AG: TcxGridDBColumn
          DataBinding.FieldName = 'AGREMP'
          Visible = False
        end
        object dbgDuplicatasCTP_CODFOR_AG: TcxGridDBColumn
          DataBinding.FieldName = 'AGRFOR'
          Visible = False
        end
        object dbgDuplicatasCTP_C_G_C: TcxGridDBColumn
          Caption = 'CNPJ/CPF'
          DataBinding.FieldName = 'FOR_C_G_C_'
        end
        object dbgDuplicatasCTA_DESCTA: TcxGridDBColumn
          Caption = 'Plano de Contas'
          DataBinding.FieldName = 'CTA_DESCTA'
          Width = 160
        end
        object dbgDuplicatasLIBERADO: TcxGridDBColumn
          Caption = 'Liberado?'
          DataBinding.FieldName = 'LIBERADO'
          Visible = False
          Width = 53
        end
        object dbgDuplicatasANTECIPACAO: TcxGridDBColumn
          Caption = 'Antecipa'#231#227'o?'
          DataBinding.FieldName = 'ANTECIPACAO'
          Width = 74
        end
      end
      object dbgDuplicatasLevel1: TcxGridLevel
        GridView = dbgDuplicatasView
      end
    end
  end
  object pnlBotoesBaixa: TPanel [5]
    Left = 0
    Top = 610
    Width = 1141
    Height = 45
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 1137
      Height = 21
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
    end
    object FlwPnlBotoesBaixa: TFlowPanel
      Left = 2
      Top = 2
      Width = 1137
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object btnAlterarValor: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 142
        Height = 21
        Caption = '[ F4 ] Alterar Valor'
        TabOrder = 0
        OnClick = btnAlterarValorClick
      end
      object btnIniBus: TBitBtnLocked
        Left = 142
        Top = 0
        Width = 142
        Height = 21
        Caption = '[ F5 ] Inicia Busca'
        TabOrder = 1
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 284
        Top = 0
        Width = 142
        Height = 21
        Caption = '[ F6 ] Localiza Pr'#243'xima'
        TabOrder = 2
        OnClick = btnLocProxClick
      end
      object btnMarcarTodas: TBitBtnLocked
        Left = 426
        Top = 0
        Width = 142
        Height = 21
        Caption = '[ F7 ] Marcar Todas'
        TabOrder = 3
        OnClick = btnMarcarTodasClick
      end
      object btnDesmarcarTodas: TBitBtnLocked
        Left = 568
        Top = 0
        Width = 142
        Height = 21
        Caption = '[ F8 ] Desmarcar Todas'
        TabOrder = 4
        OnClick = btnDesmarcarTodasClick
      end
      object BtnSelecionadas: TBitBtnLocked
        Left = 710
        Top = 0
        Width = 142
        Height = 21
        Caption = '[ F9 ] Selecionadas'
        TabOrder = 5
        OnClick = BtnSelecionadasClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 852
        Top = 0
        Width = 142
        Height = 21
        Caption = '[ F10 ] Confirma'
        TabOrder = 6
        OnClick = btnConfirmaClick
      end
      object btnBordero: TBitBtnLocked
        Left = 994
        Top = 0
        Width = 142
        Height = 21
        Caption = '[ F11 ] Imp. Border'#244
        TabOrder = 7
        OnClick = btnBorderoClick
      end
      object btnManutencao: TBitBtnLocked
        Left = 0
        Top = 21
        Width = 142
        Height = 21
        Caption = '[ F12 ] C. Pagar'
        TabOrder = 8
        OnClick = btnManutencaoClick
      end
      object btnDescontoGeral: TBitBtnLocked
        Left = 142
        Top = 21
        Width = 142
        Height = 21
        Caption = '[Alt+F12] Desconto Geral'
        TabOrder = 9
        OnClick = btnDescontoGeralClick
      end
      object btnDupAgrup: TBitBtnLocked
        Left = 284
        Top = 21
        Width = 142
        Height = 21
        Caption = '[Alt+F11] Duplic. Agrupadas'
        TabOrder = 10
        Visible = False
        OnClick = btnDupAgrupClick
      end
      object btnConfigurarGrid: TBitBtnLocked
        Left = 426
        Top = 21
        Width = 142
        Height = 21
        Align = alLeft
        Caption = 'Configurar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000900000012000000120000
          0009000000020000000000000000000000000000000000000000000000000000
          0000000000030000000A0000000A0000000B2519156F68473BFF67443BFF1D13
          0F700000000C0000000B0000000C000000050000000100000000000000000000
          00030403021A543B33C738251EB30D0907454C362DC4B5A198FFAB958AFF3E29
          23C50D080748311F1AB13A241ECE030202220000000400000000000000000000
          00085A4138C9C7B9B0FFA8958BFF6C4F47FF715044FECABAB0FFC6B5AAFF6142
          37FE6B5047FE9C857AFFA89388FF3B241FCB0000000B00000000000000000000
          00074C3930ABC0AEA7FFE3DBD5FFD2C3BAFFC1AFA6FFCFC0B7FFCEBEB5FFBCAA
          9FFFCAB9AEFFC9B8ADFF9F897FFF36221DB20000000A00000000000000010000
          0007110C0B368D6F65FCEAE3DFFFDACDC6FFD8CCC3FFE3D9D3FFE7E0DAFFE1D6
          D0FFD2C3B9FFCDBCB3FF705449FE0D0907410000000A00000002000000042A1E
          1A6B4C372EBB846356FED9CEC8FFE3DAD5FFCDBEB7FF8E6F62FF947567FFD0C0
          B9FFE3DAD3FFC8B7ADFF6A4940FF47312AC22418147100000007000000088D6D
          60FFD8CCC7FFEEE8E5FFEBE6E0FFEAE3DDFF7F6257FF2219155E241B175E9374
          67FFEBE4DFFFD6C8C0FFD3C6BDFFB9A59BFF78574BFF0000000D000000079373
          64FFD9CECAFFF6F3F2FFFAF7F6FFEFEAE5FF76574DFF1D1411551E1613568869
          5DFFEFE9E6FFDDD2CBFFD8CAC3FFC7B8B1FF7E5B4FFF0000000C000000033428
          245F665046B5937467FEECE6E3FFF0ECE8FFCEC2BDFF856961FF886D65FFD2C7
          C2FFECE4DFFFD9CFC9FF856458FD5A443AB92B201C6102010108000000000000
          000316110F2EA78B7EFDF6F4F1FFF3EFECFFF2EEEAFFF3EFECFFF0EBE7FFEFEA
          E6FFEFEBE7FFECE5E0FF83665BFD110C0B390000000600000001000000000000
          0003685349AADCD1CBFFF8F6F3FFF8F5F3FFEBE4E1FFFDFCFBFFF3EEECFFE2D8
          D3FFFAF9F8FFF9F7F5FFC8B9B3FF4E3931B00000000500000000000000000000
          0002776055BDE5DDD8FFDCD0CBFFAC9183FD9E7E6EFDFBF8F8FFF5F1EEFF9979
          6AFDA3897EFCD7CBC5FFE0D6D1FF6E564CC20000000500000000000000000000
          00010605040D7C6458BF69544BA51713102B6F594EB2E1D7D2FFE0D6D1FF6D57
          4DB314100E2B614D44A4775E53C7050404110000000100000000000000000000
          0000000000000000000100000002000000023B302A5EA68676FFA58375FF3A2F
          295F000000030000000300000003000000010000000000000000000000000000
          0000000000000000000000000000000000000000000100000002000000030000
          0001000000000000000000000000000000000000000000000000}
        TabOrder = 11
        OnClick = btnConfigurarGridClick
      end
    end
    object btnSairBaixa: TBitBtnLocked
      Left = 997
      Top = 23
      Width = 142
      Height = 21
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 2
      OnClick = btnSairBaixaClick
    end
  end
  object pnlCabecalho2: TPanel [6]
    Left = 0
    Top = 145
    Width = 1141
    Height = 52
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 4
    object Label2: TLabel
      Left = 13
      Top = 33
      Width = 101
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo  Vencimento:'
    end
    object lbl1: TLabel
      Left = 328
      Top = 33
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object lbl2: TLabel
      Left = 449
      Top = 33
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
    end
    object Label11: TLabel
      Left = 211
      Top = 33
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
    end
    object Label26: TLabel
      Left = 25
      Top = 7
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo  Cadastro:'
    end
    object Label25: TLabel
      Left = 211
      Top = 5
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
    end
    object edtVlrIni: TCurrencyEditFocus
      Tag = 99
      Left = 362
      Top = 25
      Margins.Left = 4
      Margins.Top = 1
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = '0.00;-0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 81
    end
    object edtVlrFin: TCurrencyEditFocus
      Tag = 99
      Left = 460
      Top = 25
      Margins.Left = 4
      Margins.Top = 1
      Properties.Alignment.Horz = taRightJustify
      Properties.DisplayFormat = '0.00;-0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 81
    end
    object btnConsultar: TBitBtnLocked
      Left = 547
      Top = 26
      Width = 106
      Height = 21
      Caption = '&Carregar T'#237'tulos'
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
      TabOrder = 6
      OnClick = btnConsultarClick
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 117
      Top = 25
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
      TabOrder = 2
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 223
      Top = 25
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
      TabOrder = 3
      Width = 90
    end
    object mskDtaCadIni: TcxDateEdit
      Tag = 99
      Left = 117
      Top = 0
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
    object mskDtaCadFin: TcxDateEdit
      Tag = 99
      Left = 223
      Top = 0
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
  object pnlProjeto: TPanel [7]
    Left = 0
    Top = 122
    Width = 1141
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lblProjeto: TLabel
      Left = 26
      Top = 3
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo do Projeto: '
    end
    object edtDesPrj: TEditFocus
      Left = 190
      Top = 0
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodPrj: TEditFocus
      Tag = 99
      Left = 117
      Top = 0
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodPrjExit
      OnKeyPress = edtCodPrjKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 984
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 952
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 768
    Top = 80
  end
  object frxReciboM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 42997.707318553200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbHeaderOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."intQtdReg"> <= 17 Then'
      '       rlbRodape.Visible := True'
      '  Else'
      '       rlbRodape.Visible := False;'
      ''
      
        '  pDecrementaQtdReg;                                            ' +
        '                        '
      'end;'
      ''
      'procedure rllFone01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllFone01.Text := fFormataFoneInterna(rllFone01.Text);        '
      'end;'
      ''
      'procedure rllFaxOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllFax.Text := fFormataFoneInterna(rllFax.Text);  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReciboMUserFunction
    Left = 720
    Top = 8
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
      end
      item
        DataSet = frxDatasetChqEmi
        DataSetName = 'frxDatasetChqEmi'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 148.431154138212900000
      PaperSize = 256
      FontStyle = []
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.400000000000000000
        OnBeforePrint = 'rlbHeaderOnBeforePrint'
        object rllNomEmp: TfrxDMPMemoView
          Left = 249.600000000000000000
          Top = 17.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object rllNumPag: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA')
          TruncOutboundText = False
        end
        object rllNomRel: TfrxDMPMemoView
          Left = 249.600000000000000000
          Top = 34.000000000000000000
          Width = 979.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'RELACAO DE DOCUMENTOS BAIXADOS')
          TruncOutboundText = False
        end
        object rllDtaEmi: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Top = 34.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [<Date>]')
          TruncOutboundText = False
        end
        object dmpComando: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65#18#27#80#15#27#77'
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORNECEDOR:')
          TruncOutboundText = False
        end
        object rllNomCli: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."FOR_NOMFOR"]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 68.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '-')
          TruncOutboundText = False
        end
        object rllCodCli: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_CODFOR"]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FONE / FAX:')
          TruncOutboundText = False
        end
        object rllFone01: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 85.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFone01OnAfterData'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."FOR_FONE01"]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'NUM. DOC.')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 119.000000000000000000
          Width = 86.400000000000010000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'HISTORICO')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DTA. VCTO.')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DOCUM.')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VL. PAGO')
          TruncOutboundText = False
        end
        object rllFax: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 85.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFaxOnAfterData'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."FOR_F_A_X_"]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 85.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 144.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object TotalPages: TfrxDMPMemoView
          Left = 1459.200000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TotalPages#]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
          TruncOutboundText = False
        end
        object Page: TfrxDMPMemoView
          Left = 1430.400000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DTA. PGTO.')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO')
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'MULTA')
          TruncOutboundText = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 204.000000000000000000
        Width = 1526.400000000000000000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        Stretched = True
        object rllNumDoc: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_NUMDUP"]')
          TruncOutboundText = False
        end
        object rllHist01: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_HIST01"]')
          TruncOutboundText = False
        end
        object rllDtaVen: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_DTAVEN"]')
          TruncOutboundText = False
        end
        object rllValDup: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALDUP"]')
          TruncOutboundText = False
        end
        object rllValRec: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALPAG"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CTP_DTAPAG"]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALJUR"]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALDES"]')
          TruncOutboundText = False
        end
        object DMPMemo55: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALMUL"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 459.000000000000000000
        Width = 1526.400000000000000000
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object rllAssinatura: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ASSINATURA:')
          TruncOutboundText = False
        end
        object rllRiscoAssinatura: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 68.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '_______________________________________________')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 940.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DO FORNECEDOR:')
          TruncOutboundText = False
        end
        object rllTotValDup: TfrxDMPMemoView
          Left = 960.000000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALDUP">,rlbMaster,2)]')
          TruncOutboundText = False
        end
        object rllTotValRec: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALPAG">,rlbMaster,2)]')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1171.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALMUL">,rlbMaster,2)]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 1267.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALDES">,rlbMaster,2)]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 1257.600000000000000000
          Top = 68.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo56: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALJUR">,rlbMaster,2)]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Top = 238.000000000000000000
        Width = 1526.400000000000000000
        Child = frxReciboM.CUmCheque
        PrintChildIfInvisible = True
      end
      object CVariosCheques: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 374.000000000000000000
        Width = 1526.400000000000000000
        PrintChildIfInvisible = True
        object Subreport1: TfrxSubreport
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxReciboM.Page1
        end
      end
      object CUmCheque: TfrxChild
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 255.000000000000000000
        Width = 1526.400000000000000000
        Child = frxReciboM.CVariosCheques
        PrintChildIfInvisible = True
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DADOS DO CHEQUE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BANCO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'AGENCIA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 68.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONTA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CHEQUE:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FAVORECIDO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000010000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BOM PARA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CODBCO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[NUMAGE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 68.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CONCOR]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 51.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[NUMCHQ]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[FAVORE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[DTABOM]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMITIDO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[DTAEMI]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
    object Page1: TfrxDMPPage
      PaperWidth = 393.699745735580900000
      PaperHeight = 148.431154138212900000
      PaperSize = 256
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 17.000000000000000000
        Width = 1488.000000000000000000
        DataSet = frxDatasetChqEmi
        DataSetName = 'frxDatasetChqEmi'
        RowCount = 0
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1478.400000000000000000
          Color = clBlack
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DADOS DO CHEQUE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BANCO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 85.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'AGENCIA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 85.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CONTA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CHEQUE:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FAVORECIDO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000010000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BOM PARA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataField = 'BANCO'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."BANCO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 85.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_NUMAGE'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_NUMAGE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 85.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_CONCOR'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_CONCOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 51.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_NUMCHQ'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_NUMCHQ"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 85.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_FAVORE'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_FAVORE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_BOMPAR'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_BOMPAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMITIDO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMI_DTAEMI'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_DTAEMI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 85.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'VALOR:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 85.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataField = 'VALOR_AGRUPADO'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."VALOR_AGRUPADO"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReciboJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 44659.597949351900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbHeaderOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxGen."intQtdReg"> <= 70 Then'
      '       rlbRodape.Visible := True'
      '  Else'
      '       rlbRodape.Visible := False;'
      ''
      
        '  pDecrementaQtdReg;                                            ' +
        '                        '
      'end;'
      ''
      'procedure rllFone01OnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllFone01.Text := fFormataFoneInterna(rllFone01.Text);        '
      'end;'
      ''
      'procedure rllFaxOnAfterData(Sender: TfrxComponent);'
      'begin'
      '  rllFax.Text := fFormataFoneInterna(rllFax.Text);  '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReciboMUserFunction
    Left = 792
    Top = 8
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
      end
      item
        DataSet = frxDatasetChqEmi
        DataSetName = 'frxDatasetChqEmi'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxReportPage
      PaperWidth = 310.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 103.866110000000000000
        Top = 18.897650000000000000
        Width = 1096.063700000000000000
        OnBeforePrint = 'rlbHeaderOnBeforePrint'
        object Shape1: TfrxShapeView
          Align = baBottom
          Left = 3.000000000000000000
          Top = 86.858235980000000000
          Width = 1096.063700000000000000
          Height = 17.007874020000000000
          Fill.BackColor = clSilver
        end
        object rllNomEmp: TfrxMemoView
          Align = baCenter
          Left = 185.046105000000000000
          Top = 5.661410000000000000
          Width = 725.971490000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNumPag: TfrxMemoView
          Left = 817.889610000000000000
          Top = 5.661410000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA')
        end
        object rllNomRel: TfrxMemoView
          Align = baCenter
          Left = 171.817750000000000000
          Top = 27.661410000000000000
          Width = 752.428200000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELA'#199#195'O DE DOCUMENTOS BAIXADOS')
          ParentFont = False
        end
        object rllDtaEmi: TfrxMemoView
          Left = 758.248670000000000000
          Top = 27.661410000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [<Date>]')
        end
        object Memo5: TfrxMemoView
          Left = 8.600000000000000000
          Top = 44.661410000000000000
          Width = 103.256710000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FORNECEDOR:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllNomCli: TfrxMemoView
          Left = 203.565430000000000000
          Top = 44.661410000000000000
          Width = 350.891280000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."FOR_NOMFOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 193.662770000000000000
          Top = 44.661410000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '-')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllCodCli: TfrxMemoView
          Left = 118.374520000000000000
          Top = 44.661410000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_CODFOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 8.600000000000000000
          Top = 61.661410000000000000
          Width = 82.922820000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FONE / FAX:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllFone01: TfrxMemoView
          Left = 93.563760000000000000
          Top = 61.661410000000000000
          Width = 104.466110000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFone01OnAfterData'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."FOR_FONE01"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 5.820470000000000000
          Top = 86.929116770000000000
          Width = 88.440940000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#218'M.DOC.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 108.333890000000000000
          Top = 86.929116770000000000
          Width = 84.359060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'HIST'#211'RICO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 499.275590550000000000
          Top = 86.929116770000000000
          Width = 77.404700000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA. VCTO.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 660.694461340000000000
          Top = 86.929116770000000000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DOCUM.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 1013.291375200000000000
          Top = 86.929116770000000000
          Width = 78.992118660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. PAGO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllFax: TfrxMemoView
          Left = 211.711750000000000000
          Top = 61.661410000000000000
          Width = 100.686580000000000000
          Height = 17.000000000000000000
          OnAfterData = 'rllFaxOnAfterData'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."FOR_F_A_X_"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 200.070810000000000000
          Top = 61.661410000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '/')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 965.669140000000000000
          Top = 27.661410000000000000
          Width = 57.902350000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[Time]')
        end
        object TotalPages: TfrxMemoView
          Left = 1005.330550000000000000
          Top = 5.661410000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TotalPages#]')
        end
        object Memo4: TfrxMemoView
          Left = 994.171490000000000000
          Top = 5.661410000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
        end
        object Page: TfrxMemoView
          Left = 972.971490000000000000
          Top = 5.661410000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
        end
        object Memo1: TfrxMemoView
          Left = 577.433520000000000000
          Top = 86.929190000000000000
          Width = 81.259835200000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DTA. PGTO.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 753.126470000000000000
          Top = 86.929116770000000000
          Width = 86.551178660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 921.307670000000000000
          Top = 86.929190000000000000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 840.835190000000000000
          Top = 86.929190000000000000
          Width = 78.992118660000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MULTA')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 20.787401570000000000
        Top = 230.551330000000000000
        Width = 1096.063700000000000000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        Stretched = True
        object rllNumDoc: TfrxMemoView
          Left = 5.820470000000000000
          Width = 99.779530000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_NUMDUP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllHist01: TfrxMemoView
          Left = 106.554360000000000000
          Width = 389.518120000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_HIST01"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllDtaVen: TfrxMemoView
          Left = 498.347990000000000000
          Width = 77.480314960000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDataset."CTP_DTAVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllValDup: TfrxMemoView
          Left = 661.322820000000000000
          Width = 90.481880000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALDUP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllValRec: TfrxMemoView
          Left = 1013.291375200000000000
          Width = 78.992118660000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALPAG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 577.511811020000000000
          Width = 81.259842519685000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CTP_DTAPAG"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 753.905997560000000000
          Width = 86.551181100000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALJUR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 925.087197560000000000
          Width = 86.551181100000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALDES"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Left = 840.944881889763800000
          Width = 86.551181100000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."CTP_VALMUL"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 77.425170000000000000
        Top = 476.220780000000000000
        Width = 1096.063700000000000000
        object Line4: TfrxLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1088.503963860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllAssinatura: TfrxMemoView
          Left = 288.000000000000000000
          Top = 47.000000000000000000
          Width = 94.261410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ASSINATURA:')
        end
        object rllRiscoAssinatura: TfrxMemoView
          Left = 384.302350000000000000
          Top = 47.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '_______________________________________________')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 4.800000000000000000
          Top = 8.000000000000000000
          Width = 651.666420000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL DO FORNECEDOR:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTotValDup: TfrxMemoView
          Left = 660.661417322834900000
          Top = 8.000000000000000000
          Width = 97.889768660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALDUP">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object rllTotValRec: TfrxMemoView
          Left = 1013.291375200000000000
          Top = 8.000000000000000000
          Width = 78.992118660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALPAG">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 840.944881889763800000
          Top = 8.000000000000000000
          Width = 82.771648660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALMUL">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 921.448818900000000000
          Top = 8.000000000000000000
          Width = 90.330708660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALDES">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Line2: TfrxLineView
          Left = 4.800000000000000000
          Top = 7.559060000000000000
          Width = 1088.504640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo40: TfrxMemoView
          Left = 929.984850000000000000
          Top = 45.354360000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 760.818902520000000000
          Top = 7.559060000000000000
          Width = 78.992118660000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."CTP_VALJUR">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 1.944960000000000000
        Top = 275.905690000000000000
        Width = 1096.063700000000000000
        Child = frxReciboJ.CUmCheque
        PrintChildIfInvisible = True
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 185.196970000000000000
        Width = 1096.063700000000000000
      end
      object CUmCheque: TfrxChild
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 302.362400000000000000
        Width = 1096.063700000000000000
        Child = frxReciboJ.CVariosCheques
        PrintChildIfInvisible = True
        object rllBanco: TfrxMemoView
          Left = 3.779530000000000000
          Top = 22.747990000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Banco:')
          ParentFont = False
        end
        object rllAgencia: TfrxMemoView
          Left = 339.740260000000000000
          Top = 22.747990000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ag'#234'ncia:')
          ParentFont = False
        end
        object rllConta: TfrxMemoView
          Left = 535.850650000000000000
          Top = 22.747990000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Conta:')
          ParentFont = False
        end
        object rllFavorecido: TfrxMemoView
          Left = 3.779530000000000000
          Top = 45.425170000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Favorecido:')
          ParentFont = False
        end
        object rllBomPara: TfrxMemoView
          Left = 535.889920000000000000
          Top = 45.425170000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bom para:')
          ParentFont = False
        end
        object rllCodBco: TfrxMemoView
          Left = 53.692950000000000000
          Top = 22.747990000000000000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODBCO]')
          ParentFont = False
        end
        object rllNumAge: TfrxMemoView
          Left = 400.992270000000000000
          Top = 22.747990000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NUMAGE]')
          ParentFont = False
        end
        object rllConCor: TfrxMemoView
          Left = 584.764070000000000000
          Top = 22.747990000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CONCOR]')
          ParentFont = False
        end
        object rllFacore: TfrxMemoView
          Left = 83.929190000000000000
          Top = 45.425170000000000000
          Width = 445.984540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FAVORE]')
          ParentFont = False
        end
        object rllDtaBom: TfrxMemoView
          Left = 609.480520000000000000
          Top = 45.425170000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTABOM]')
          ParentFont = False
        end
        object rllCheque: TfrxMemoView
          Left = 786.299630000000000000
          Top = 22.747990000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cheque:')
          ParentFont = False
        end
        object rllNumChq: TfrxMemoView
          Left = 842.992580000000000000
          Top = 22.747990000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NUMCHQ]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Top = 1.291279999999970000
          Width = 1088.503963860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo8: TfrxMemoView
          Left = 786.299630000000000000
          Top = 45.425170000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emitido:')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 844.110700000000000000
          Top = 45.425170000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAEMI]')
          ParentFont = False
        end
        object rllDadChq: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.291279999999970000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dados do Cheque:')
          ParentFont = False
        end
      end
      object CVariosCheques: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 393.071120000000000000
        Width = 1096.063700000000000000
        PrintChildIfInvisible = True
        object Subreport1: TfrxSubreport
          Left = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReciboJ.Page1
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 310.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 79.370130000000000000
        Top = 18.897650000000000000
        Width = 1096.063700000000000000
        DataSet = frxDatasetChqEmi
        DataSetName = 'frxDatasetChqEmi'
        RowCount = 0
        object Memo23: TfrxMemoView
          Left = 3.779530000000000000
          Top = 24.236240000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Banco:')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 339.740260000000000000
          Top = 24.236240000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ag'#234'ncia:')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 535.850650000000000000
          Top = 24.236240000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Conta:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 3.779530000000000000
          Top = 46.913420000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Favorecido:')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 535.889920000000000000
          Top = 46.913420000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Bom para:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 53.692950000000000000
          Top = 24.236240000000000000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          DataField = 'BANCO'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."BANCO"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 400.992270000000000000
          Top = 24.236240000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_NUMAGE'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_NUMAGE"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 584.764070000000000000
          Top = 24.236240000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_CONCOR'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_CONCOR"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 83.929190000000000000
          Top = 46.913420000000000000
          Width = 445.984540000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_FAVORE'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_FAVORE"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 609.480520000000000000
          Top = 46.913420000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_BOMPAR'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_BOMPAR"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 786.299630000000000000
          Top = 24.236240000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cheque:')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 842.992580000000000000
          Top = 24.236240000000000000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_NUMCHQ'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_NUMCHQ"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 786.299630000000000000
          Top = 46.913420000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emitido:')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 844.110700000000000000
          Top = 46.913420000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'EMI_DTAEMI'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."EMI_DTAEMI"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dados do Cheque:')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 943.662030000000000000
          Top = 46.354360000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 987.236860000000000000
          Top = 46.354360000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'VALOR_AGRUPADO'
          DataSet = frxDatasetChqEmi
          DataSetName = 'frxDatasetChqEmi'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetChqEmi."VALOR_AGRUPADO"]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 3.000000000000000000
          Top = 71.811070000000000000
          Width = 1088.503963860000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDataset: TfrxDBDataset
    UserName = 'frxDataset'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 856
    Top = 8
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    OnGetValue = frxGenGetValue
    Left = 920
    Top = 8
  end
  object frxDatasetChqEmi: TfrxDBDataset
    UserName = 'frxDatasetChqEmi'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 856
    Top = 64
  end
end
