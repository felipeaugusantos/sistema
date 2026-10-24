inherited frmFatManConsertoEquip: TfrmFatManConsertoEquip
  Left = 269
  Top = 124
  Width = 1366
  Height = 768
  Caption = 'Manuten'#231#227'o de Ordem de Servi'#231'os - Conserto de Equipamentos'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1366
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 723
    Width = 1360
    TabOrder = 3
    ExplicitTop = 723
    ExplicitWidth = 1360
    inherited FlwBotoes: TFlowPanel
      Width = 1356
      ExplicitWidth = 1356
    end
    inherited btnSair: TBitBtnLocked
      Left = 686
      Top = -166
      ExplicitLeft = 686
      ExplicitTop = -166
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1360
    ExplicitTop = 723
    ExplicitWidth = 1360
    inherited pnlNomeForm: TPanel
      Left = 1189
      ExplicitLeft = 1189
    end
    inherited pnlInfo: TPanel
      Width = 1189
      ExplicitWidth = 1189
    end
  end
  inherited pgcDados: TPageControl
    Width = 1360
    Height = 723
    ExplicitWidth = 1360
    ExplicitHeight = 723
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1352
      ExplicitHeight = 691
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 1360
    Height = 723
    Align = alClient
    BevelOuter = bvNone
    Caption = #39
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object pnlTopo: TPanel
      Left = 0
      Top = 16
      Width = 1360
      Height = 315
      Align = alTop
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      object pnlRealizada: TPanel
        Left = 1
        Top = 286
        Width = 1358
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        DesignSize = (
          1358
          25)
        object lblStaRealizada: TLabel
          Left = 7
          Top = 6
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Sit. Realizada:'
        end
        object lblRetiradoPor: TLabel
          Left = 292
          Top = 6
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = 'Retirado Por:'
        end
        object cmbStaRealizada: TComboBoxFocus
          Tag = 99
          Left = 76
          Top = 3
          Width = 180
          Height = 22
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 0
          Items.Strings = (
            'Devolvida ao Cliente'
            'Armazenada')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtRetiradoPor: TEditFocus
          Tag = 99
          Left = 356
          Top = 3
          Width = 522
          Height = 22
          Alignment = taLeftJustify
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 50
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlGrpBox: TPanel
        Left = 1
        Top = 1
        Width = 1358
        Height = 285
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object gbDadGerOS: TGroupBox
          Left = 0
          Top = 0
          Width = 678
          Height = 285
          Align = alLeft
          Caption = 'Dados Gerais da Ordem de Servi'#231'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object pnlVendedor: TPanel
            Left = 2
            Top = 161
            Width = 674
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 3
            DesignSize = (
              674
              24)
            object Label3: TLabel
              Left = 23
              Top = 3
              Width = 50
              Height = 14
              Alignment = taRightJustify
              Caption = 'Vendedor:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label11: TLabel
              Left = 367
              Top = 4
              Width = 41
              Height = 14
              Alignment = taRightJustify
              Caption = 'T'#233'cnico:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object edtSenVen: TEditFocus
              Tag = 99
              Left = 74
              Top = 0
              Width = 45
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              ParentFont = False
              PasswordChar = '*'
              TabOrder = 0
              OnExit = edtSenVenExit
              OnKeyPress = edtSenVenKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 10
              TipoTexto = ttAlfanumerico
            end
            object edtNomVen: TEditFocus
              Left = 120
              Top = 0
              Width = 215
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              Color = 16768952
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
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
            object edtCodTec: TEditFocus
              Tag = 99
              Left = 409
              Top = 0
              Width = 45
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              ParentFont = False
              TabOrder = 2
              OnKeyPress = edtCodTecKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 3
              TipoTexto = ttAlfanumerico
            end
            object edtDesTec: TEditFocus
              Left = 455
              Top = 0
              Width = 215
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Anchors = [akLeft, akTop, akRight]
              CharCase = ecUpperCase
              Color = 16768952
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
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
          object pnlRevRetEnt: TPanel
            Left = 2
            Top = 137
            Width = 674
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 2
            object Label27: TLabel
              Left = 27
              Top = 3
              Width = 46
              Height = 14
              Alignment = taRightJustify
              Caption = 'Revenda:'
            end
            object Label28: TLabel
              Left = 191
              Top = 4
              Width = 70
              Height = 14
              Alignment = taRightJustify
              Caption = 'Retornar para:'
            end
            object Label29: TLabel
              Left = 380
              Top = 4
              Width = 61
              Height = 14
              Alignment = taRightJustify
              Caption = 'Deixado Por:'
            end
            object edtRevend: TEditFocus
              Tag = 99
              Left = 74
              Top = 0
              Width = 113
              Height = 22
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 50
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 50
              TipoTexto = ttAlfanumerico
            end
            object edtConRet: TEditFocus
              Tag = 99
              Left = 260
              Top = 0
              Width = 113
              Height = 22
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 50
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 50
              TipoTexto = ttAlfanumerico
            end
            object edtDeiPor: TEditFocus
              Tag = 99
              Left = 442
              Top = 0
              Width = 104
              Height = 22
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 50
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 50
              TipoTexto = ttAlfanumerico
            end
            object chkVenPre: TCheckBox
              AlignWithMargins = True
              Left = 551
              Top = 4
              Width = 115
              Height = 14
              Margins.Left = 66
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Caption = 'Venda Presencial?'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              Visible = False
              OnClick = chkVenPreClick
              OnEnter = chkVenPreEnter
              OnExit = chkVenPreExit
            end
          end
          object pnlCliente: TPanel
            Left = 2
            Top = 40
            Width = 674
            Height = 97
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 1
            object pnlCodCli: TPanel
              Left = 0
              Top = 0
              Width = 674
              Height = 24
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
              DesignSize = (
                674
                24)
              object lblCliFor: TLabel
                Left = 38
                Top = 7
                Width = 35
                Height = 14
                Alignment = taRightJustify
                Caption = 'Cliente:'
              end
              object lblTabPreco: TLabel
                Left = 581
                Top = 7
                Width = 51
                Height = 14
                Anchors = [akTop, akRight]
                Caption = 'Tab.Pre'#231'o:'
              end
              object edtCodCli: TEditFocus
                Tag = 99
                Left = 74
                Top = 1
                Width = 65
                Height = 22
                Alignment = taRightJustify
                CharCase = ecUpperCase
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                TabOrder = 0
                OnEnter = edtCodCliEnter
                OnExit = edtCodCliExit
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
                Left = 140
                Top = 1
                Width = 435
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Anchors = [akLeft, akTop, akRight]
                CharCase = ecUpperCase
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
              object cbTabPreco: TComboBoxFocus
                Tag = 99
                Left = 632
                Top = 1
                Width = 38
                Height = 22
                Anchors = [akTop, akRight]
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 1
                Sorted = True
                TabOrder = 2
                OnExit = cbTabPrecoExit
                OnKeyPress = cbTabPrecoKeyPress
                OnSelect = cbTabPrecoExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
              end
            end
            object pnlFazenda: TPanel
              Left = 0
              Top = 24
              Width = 674
              Height = 24
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              DesignSize = (
                674
                24)
              object lblFazenda: TLabel
                Left = 28
                Top = 5
                Width = 45
                Height = 14
                Alignment = taRightJustify
                Caption = 'Fazenda:'
              end
              object edtFazenda: TEditFocus
                Left = 74
                Top = 1
                Width = 552
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Anchors = [akLeft, akTop, akRight]
                CharCase = ecUpperCase
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
              object btnAlterarFazenda: TcxButton
                Left = 638
                Top = 1
                Width = 32
                Height = 22
                Hint = 'Alterar Fazenda'
                LookAndFeel.Kind = lfUltraFlat
                OptionsImage.Glyph.SourceDPI = 96
                OptionsImage.Glyph.Data = {
                  89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                  6100000020744558745469746C6500456469743B426172733B526962626F6E3B
                  5374616E646172643B3013C3DB0000028449444154785E5D515D48145114FEEE
                  CE9AA662FE942B1499246108D94B106588D24B461914843DD443500FF590D81F
                  F550D443692F86A1A084AB581AD90F124260A4596AB14A96B556AC6192FDA045
                  AEB3BBCE9DB9B77BE732BBEA99F9CEB9C39CEF3BDF9C219C731042B496CEB167
                  9AA6157170C89045BE53C758A286D177F4C0A69D826700801B2A5C42A4E85069
                  2E9CE08B12711EE07DFC6907004DD16202C4B254834119B823C2559297BA092C
                  66D9FD4B05603135832D602BBEE348C134B923B0D40175BE3B4A8AED80280191
                  2D93D9FDAF6E6C4744A70B05542B63311224513A23CA8D26EAE6BC3400482C3C
                  DB6F00A02E47C0A41694650E0680896AC933E1F699886ACCCF636EB419DD97B6
                  FC6A3ABEB10A4092E300865A22989CCA17FF46108648288C89170DC84D1B41CE
                  E17BF0B7579CBAFE3DE88E3A60A6691319531305D462B920EB3AC69FD7211583
                  C8D9530DFAB5067F3E04A045CC93D11D50CA94804CB610E0727184F520023DF5
                  58A5F9B07E5F0DC21FABF1A6B907C8F4E0CBCFC9A69880A5044489EE7D6EF61F
                  C67BEA904986B0E1602D667D573174A70FD64A0FDA6E0FB77AC782179C25C2B2
                  991CC9091A92E25D6086B47D0B19F435F2CA6B31DD7BD19E1C4E4E87D7FBB65D
                  90CF0198761C987A48EFBD7CB3BF880358E34900D7032808FA905F598FA9AE4A
                  8C3E194638291D775BDFDFEF98089F01F0BBDCB3CC74362D9D2C1748115821B0
                  2E6FEB91879D0DD7B83E39C8BB8E65F3F613F9BC6C75FC0300D902EE40DB2EEC
                  CF888314588497D5DB00606D4149C58F77034F794BD5797EA538979766C53F02
                  902310E76F2C81BFB1187B5335B8B12422212A0BF9F67924ABB0AC6F8646FE0E
                  249A531D33A1F96E697B778A464F57F6AA8100FE037C7D7091F11B3976000000
                  0049454E44AE426082}
                OptionsImage.Margin = 4
                TabOrder = 1
                OnClick = btnAlterarFazendaClick
              end
            end
            object pnlDadosCliente: TPanel
              Left = 0
              Top = 48
              Width = 674
              Height = 49
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 2
              DesignSize = (
                674
                49)
              object lblFone01: TLabel
                Left = 29
                Top = 5
                Width = 44
                Height = 14
                Alignment = taRightJustify
                Caption = 'Telefone:'
              end
              object lblCelula: TLabel
                Left = 167
                Top = 5
                Width = 36
                Height = 14
                Alignment = taRightJustify
                Caption = 'Celular:'
              end
              object lblEmail: TLabel
                Left = 299
                Top = 5
                Width = 27
                Height = 14
                Alignment = taRightJustify
                Caption = 'Email:'
              end
              object lblDtaInc: TLabel
                Left = 521
                Top = 5
                Width = 77
                Height = 14
                Alignment = taRightJustify
                Caption = 'Dt. Inclus'#227'o OS:'
              end
              object lblPreEnt: TLabel
                Left = 379
                Top = 29
                Width = 85
                Height = 14
                Caption = 'Previs'#227'o Entrega:'
              end
              object Label39: TLabel
                Left = 201
                Top = 29
                Width = 59
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tel. Contato:'
              end
              object Label37: TLabel
                Left = 33
                Top = 29
                Width = 40
                Height = 14
                Alignment = taRightJustify
                Caption = 'Contato:'
              end
              object edtFone01: TEditFocus
                Left = 74
                Top = 1
                Width = 85
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                CharCase = ecUpperCase
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
              object edtCelula: TEditFocus
                Left = 204
                Top = 1
                Width = 85
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                CharCase = ecUpperCase
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
              object edtEmail_: TEditFocus
                Left = 328
                Top = 1
                Width = 185
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                Anchors = [akLeft, akTop, akRight]
                CharCase = ecUpperCase
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
              object mskDtaInc: TMaskEditFocus
                Tag = 99
                Left = 600
                Top = 1
                Width = 70
                Height = 22
                CharCase = ecUpperCase
                Color = 16768952
                EditMask = '99/99/9999'
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 10
                ReadOnly = True
                TabOrder = 3
                Text = '  /  /    '
                NormalColor = 16768952
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                ValidaData = True
              end
              object chkPrtAtd: TCheckBox
                Left = 551
                Top = 27
                Width = 119
                Height = 17
                Caption = 'Pronto Atendimento?'
                TabOrder = 4
                OnClick = chkPrtAtdClick
              end
              object edtDiaEnt: TEditFocus
                Tag = 99
                Left = 496
                Top = 25
                Width = 50
                Height = 22
                Alignment = taRightJustify
                AutoSize = False
                CharCase = ecUpperCase
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 50
                TabOrder = 5
                Text = '0'
                Visible = False
                OnExit = edtDiaEntExit
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 50
                TipoTexto = ttAlfanumerico
              end
              object mskEntreg: TMaskEditFocus
                Tag = 99
                Left = 464
                Top = 25
                Width = 82
                Height = 22
                CharCase = ecUpperCase
                EditMask = '99/99/9999'
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 10
                TabOrder = 6
                Text = '  /  /    '
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                ValidaData = True
              end
              object mskCntTel: TMaskEditTelefone
                Tag = 99
                Left = 260
                Top = 25
                Width = 113
                Height = 22
                CharCase = ecUpperCase
                EditMask = '!\(99\)9999-9999;0;_'
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 13
                TabOrder = 7
                Text = ''
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                ValidaData = False
                Pais = opcBrasil
              end
              object edtCntCli: TEditFocus
                Tag = 99
                Left = 74
                Top = 25
                Width = 113
                Height = 22
                Alignment = taLeftJustify
                AutoSize = False
                CharCase = ecUpperCase
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 25
                TabOrder = 8
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 50
                TipoTexto = ttAlfanumerico
              end
            end
          end
          object pnlNumeroOS: TPanel
            Left = 2
            Top = 16
            Width = 674
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            object lblMargem: TLabel
              Left = 33
              Top = 6
              Width = 40
              Height = 14
              Alignment = taRightJustify
              Caption = 'N'#250'mero:'
            end
            object lblEmpresa: TLabel
              Left = 143
              Top = 6
              Width = 45
              Height = 14
              Alignment = taRightJustify
              Caption = 'Empresa:'
            end
            object lblStatus: TLabel
              Left = 448
              Top = 4
              Width = 218
              Height = 18
              Alignment = taRightJustify
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblNovaOrdem: TLabel
              Left = 380
              Top = 6
              Width = 135
              Height = 14
              AutoSize = False
              Caption = 'Nova Ordem de Servi'#231'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              Visible = False
            end
            object lblProtoc: TLabel
              Left = 519
              Top = 6
              Width = 48
              Height = 14
              Alignment = taRightJustify
              Caption = 'Protocolo:'
            end
            object edtNumero: TEditFocus
              Tag = 99
              Left = 74
              Top = 1
              Width = 65
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
              MaxLength = 6
              ParentFont = False
              TabOrder = 0
              OnEnter = edtNumeroEnter
              OnExit = edtNumeroExit
              OnKeyPress = edtNumeroKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 6
              TipoTexto = ttInteiro
            end
            object edtCodEmp: TEditFocus
              Tag = 99
              Left = 191
              Top = 1
              Width = 31
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
              TabOrder = 1
              Text = '001'
              OnExit = edtCodEmpExit
              OnKeyPress = edtCodEmpKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 3
              TipoTexto = ttInteiro
            end
            object edtDesEmp: TEditFocus
              Left = 223
              Top = 1
              Width = 290
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              CharCase = ecUpperCase
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
            object edtProtoc: TEditFocus
              Tag = 99
              Left = 568
              Top = 1
              Width = 102
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
              MaxLength = 15
              ParentFont = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 15
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlCndPag: TPanel
            Left = 2
            Top = 209
            Width = 674
            Height = 73
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 5
            DesignSize = (
              674
              73)
            object lblCndPag: TLabel
              Left = 12
              Top = 3
              Width = 61
              Height = 14
              Alignment = taRightJustify
              Caption = 'Cond. Pagto:'
            end
            object Label14: TLabel
              Left = 13
              Top = 51
              Width = 60
              Height = 14
              Alignment = taRightJustify
              Caption = 'Form. Pagto:'
            end
            object edtCodCnd: TEditFocus
              Tag = 99
              Left = 74
              Top = 0
              Width = 45
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              TabOrder = 0
              OnEnter = edtCodCndEnter
              OnExit = edtCodCndExit
              OnKeyPress = edtCodCndKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 3
              TipoTexto = ttAlfanumerico
            end
            object mskCndPag: TMaskEditFocus
              Tag = 99
              Left = 120
              Top = 0
              Width = 550
              Height = 22
              Anchors = [akLeft, akTop, akRight]
              CharCase = ecUpperCase
              EditMask = 
                '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
                '99.999.999.999.999.999.999.999.999;0;_'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 98
              TabOrder = 1
              Text = ''
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
            object edtDesCndPag: TEditFocus
              Left = 74
              Top = 24
              Width = 596
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Anchors = [akLeft, akTop, akRight]
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
            object edtForPag: TEditFocus
              Tag = 99
              Left = 74
              Top = 48
              Width = 65
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              TabOrder = 3
              OnKeyPress = edtForPagKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 3
              TipoTexto = ttNumerico
            end
            object edtDesForPag: TEditFocus
              Left = 140
              Top = 48
              Width = 530
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Anchors = [akLeft, akTop, akRight]
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
          object pnlRepDig: TPanel
            Left = 2
            Top = 185
            Width = 674
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 4
            DesignSize = (
              674
              24)
            object lblCodRep: TLabel
              Left = 14
              Top = 3
              Width = 59
              Height = 14
              Alignment = taRightJustify
              Caption = 'Vendedor 2:'
            end
            object lblDigita: TLabel
              Left = 363
              Top = 4
              Width = 45
              Height = 14
              Alignment = taRightJustify
              Caption = 'Digitador:'
            end
            object edtCodRep: TEditFocus
              Tag = 99
              Left = 74
              Top = 0
              Width = 45
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              TabOrder = 0
              OnKeyPress = edtCodRepKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 3
              TipoTexto = ttAlfanumerico
            end
            object edtDesRep: TEditFocus
              Left = 120
              Top = 0
              Width = 215
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              CharCase = ecUpperCase
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
            object edtSenDig: TEditFocus
              Tag = 99
              Left = 409
              Top = 0
              Width = 45
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              PasswordChar = '*'
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 10
              TipoTexto = ttAlfanumerico
            end
            object edtNomDig: TEditFocus
              Left = 455
              Top = 0
              Width = 215
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Anchors = [akLeft, akTop, akRight]
              CharCase = ecUpperCase
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
        end
        object gbDadEqu: TGroupBox
          Left = 678
          Top = 0
          Width = 680
          Height = 285
          Align = alClient
          Caption = 'Dados do Equipamento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object pnlBotton: TPanel
            Left = 2
            Top = 16
            Width = 676
            Height = 267
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              676
              267)
            object lblObserv: TLabel
              Left = 23
              Top = 209
              Width = 50
              Height = 28
              Alignment = taRightJustify
              Caption = 'Obs. OR/PD/NF:'
              WordWrap = True
            end
            object Label13: TLabel
              Left = 382
              Top = 4
              Width = 33
              Height = 14
              Alignment = taRightJustify
              Caption = 'Marca:'
            end
            object Label18: TLabel
              Left = 9
              Top = 5
              Width = 64
              Height = 14
              Alignment = taRightJustify
              Caption = 'Equipamento:'
            end
            object Label21: TLabel
              Left = 609
              Top = 4
              Width = 24
              Height = 14
              Alignment = taRightJustify
              Caption = 'Volt.:'
            end
            object Label22: TLabel
              Left = 25
              Top = 53
              Width = 43
              Height = 14
              Alignment = taRightJustify
              Caption = 'N'#186' S'#233'rie:'
            end
            object lblGarant: TLabel
              Left = 380
              Top = 76
              Width = 64
              Height = 14
              Alignment = taRightJustify
              Caption = 'Em Garantia?'
            end
            object lblNroDoc: TLabel
              Left = 17
              Top = 100
              Width = 56
              Height = 14
              Alignment = taRightJustify
              Caption = 'NF Compra:'
            end
            object lblDatEnt: TLabel
              Left = 245
              Top = 101
              Width = 99
              Height = 14
              Alignment = taRightJustify
              Caption = 'Emiss'#227'o NF Compra:'
            end
            object lblLocFis: TLabel
              Left = 30
              Top = 31
              Width = 44
              Height = 14
              Alignment = taRightJustify
              Caption = 'Loc. F'#237's.:'
            end
            object Label23: TLabel
              Left = 258
              Top = 53
              Width = 67
              Height = 14
              Alignment = taRightJustify
              Caption = 'N'#186' Patrim'#244'nio:'
            end
            object Label41: TLabel
              Left = 482
              Top = 53
              Width = 61
              Height = 14
              Alignment = taRightJustify
              Caption = 'Dados Fabr.:'
            end
            object lblNOSAnt: TLabel
              Left = 14
              Top = 77
              Width = 59
              Height = 14
              Alignment = taRightJustify
              Caption = 'OS Anterior:'
            end
            object lblDtEAnt: TLabel
              Left = 123
              Top = 77
              Width = 46
              Height = 14
              Alignment = taRightJustify
              Caption = 'Entr. Ant.:'
            end
            object lblEstPrd: TLabel
              Left = 266
              Top = 31
              Width = 79
              Height = 14
              Alignment = taRightJustify
              Caption = 'Estado do Prod.:'
              Visible = False
            end
            object lblTmpGar: TLabel
              Left = 570
              Top = 77
              Width = 68
              Height = 14
              Alignment = taRightJustify
              Caption = 'Dias Garantia:'
            end
            object lblNOSFab: TLabel
              Left = 446
              Top = 101
              Width = 72
              Height = 14
              Alignment = taRightJustify
              Caption = 'OS Fabricante:'
              Visible = False
            end
            object lblDtNFRe: TLabel
              Left = 237
              Top = 125
              Width = 107
              Height = 14
              Alignment = taRightJustify
              Caption = 'Emiss'#227'o NF Remessa:'
            end
            object lblNFReme: TLabel
              Left = 9
              Top = 124
              Width = 64
              Height = 14
              Alignment = taRightJustify
              Caption = 'NF Remessa:'
            end
            object lblDtRAnt: TLabel
              Left = 237
              Top = 76
              Width = 44
              Height = 14
              Alignment = taRightJustify
              Caption = 'Ret. Ant.:'
            end
            object lblObsGer: TLabel
              Left = 12
              Top = 148
              Width = 61
              Height = 14
              Alignment = taRightJustify
              Caption = 'Obs. Gerais:'
              WordWrap = True
            end
            object lblObsNFS: TLabel
              Left = 10
              Top = 177
              Width = 63
              Height = 28
              Alignment = taRightJustify
              Caption = '        Obs. NFS Servi'#231'o:'
              WordWrap = True
            end
            object edtObs: TMemoFocus
              Tag = 99
              Left = 74
              Top = 209
              Width = 461
              Height = 54
              Anchors = [akLeft, akTop, akBottom]
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 25
              OnExit = edtObsExit
              OnKeyDown = edtObsKeyDown
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              StringQuebra = '<<csq>>'
            end
            object edtDesMar: TEditFocus
              Left = 416
              Top = 1
              Width = 187
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
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
            object edtCodEqu: TEditFocus
              Tag = 99
              Left = 74
              Top = 1
              Width = 49
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 5
              TabOrder = 0
              OnEnter = edtCodEquEnter
              OnExit = edtCodEquExit
              OnKeyPress = edtCodEquKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesEqu: TEditFocus
              Left = 124
              Top = 1
              Width = 252
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              CharCase = ecUpperCase
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
            object edtVoltag: TEditFocus
              Left = 635
              Top = 1
              Width = 35
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
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
            object edtNSerie: TEditFocus
              Tag = 99
              Left = 74
              Top = 49
              Width = 148
              Height = 22
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 30
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 30
              TipoTexto = ttAlfanumerico
            end
            object edtNFComp: TEditFocus
              Tag = 99
              Left = 74
              Top = 97
              Width = 148
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 12
              TabOrder = 18
              OnKeyPress = edtNFCompKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 12
              TipoTexto = ttNumerico
            end
            object mskDtNFco: TMaskEditFocus
              Tag = 99
              Left = 347
              Top = 97
              Width = 78
              Height = 22
              CharCase = ecUpperCase
              EditMask = '99/99/9999'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              TabOrder = 19
              Text = '  /  /    '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = True
            end
            object cbGarant: TComboBoxFocus
              Tag = 99
              Left = 446
              Top = 73
              Width = 121
              Height = 22
              Style = csOwnerDrawFixed
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ItemIndex = 0
              MaxLength = 1
              TabOrder = 16
              Text = 'N'#227'o'
              OnChange = cbGarantChange
              Items.Strings = (
                'N'#227'o'
                'Garantia Loja'
                'Garantia F'#225'brica'
                'Retorno de Garantia')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object edtLocFis: TEditFocus
              Tag = 99
              Left = 74
              Top = 25
              Width = 148
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 30
              TabOrder = 4
              OnKeyPress = edtLocFisKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 20
              TipoTexto = ttAlfanumerico
            end
            object edtNumPat: TEditFocus
              Tag = 99
              Left = 326
              Top = 49
              Width = 150
              Height = 22
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 30
              TabOrder = 10
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 30
              TipoTexto = ttAlfanumerico
            end
            object edtDadFab: TEditFocus
              Tag = 99
              Left = 544
              Top = 49
              Width = 126
              Height = 22
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 30
              TabOrder = 11
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 30
              TipoTexto = ttAlfanumerico
            end
            object cbEstPrd: TComboBoxFocus
              Left = 345
              Top = 25
              Width = 150
              Height = 22
              Style = csDropDownList
              TabOrder = 7
              Visible = False
              OnExit = cbEstPrdExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object edtTmpGar: TEditFocus
              Tag = 99
              Left = 639
              Top = 73
              Width = 31
              Height = 22
              Alignment = taRightJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 12
              TabOrder = 17
              OnKeyPress = edtNFCompKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 12
              TipoTexto = ttNumerico
            end
            object edtNOSFab: TEditFocus
              Tag = 99
              Left = 522
              Top = 97
              Width = 148
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 15
              TabOrder = 20
              Visible = False
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 15
              TipoTexto = ttAlfanumerico
            end
            object edtNOSAnt: TEditFocus
              Tag = 99
              Left = 74
              Top = 73
              Width = 47
              Height = 22
              Alignment = taLeftJustify
              AutoSize = False
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 6
              TabOrder = 12
              OnExit = edtNOSAntExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 6
              TipoTexto = ttInteiro
            end
            object mskDtEAnt: TMaskEditFocus
              Tag = 99
              Left = 170
              Top = 73
              Width = 63
              Height = 22
              CharCase = ecUpperCase
              EditMask = '99/99/9999'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              TabOrder = 13
              Text = '  /  /    '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = True
            end
            object btnGridMostraOS: TBitBtnLocked
              Tag = 50
              Left = 349
              Top = 73
              Width = 28
              Height = 22
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000020000
                000A000000160000001B000000170000000B0000000200000000000000010000
                00060000000B0000000F0000000C0000000600000001000000000000000F2616
                1072583424D8693D2AFF4D2C1FD91D110B750000001200000003000000082416
                1162513023CF613927FF45281BD01A0F0A630000000900000001291A136DA380
                70FFD4C5BDFFEDE5E1FFCFBEB7FF907163FF1F120C770000000F2C1C1663A181
                72FFD4C6BEFFEEE8E4FFCDC0B8FF866A5DFF190E096000000005734937DEE3D7
                D1FFCEAE9EFFAF7957FFD0B39EFFD7C9C3FF553324E00000001B77503FD8E2D7
                D2FFD0AD9BFFB37753FFD2B29AFFD6CBC5FF4A2B1ED90000000A8E5A47FBF8F6
                F4FFAE725BFFE7AF66FFB27F5EFFF0EBE8FF744835FF000000489A6B55FFF8F6
                F3FFB27056FFE8AF64FFB67E59FFEAE3DFFF613B29FA0000000B90604DF8F1E8
                E4FFD2B0A5FFAA6C53FFD4B6A7FFCDC0BAFF71422FFF4C2920FF80513DFFF1E8
                E3FFD3ADA1FFAE684FFFD4B2A1FFC5B6AFFF6A4231F700000009583C31A2CAAF
                A3FFF7F2EEFFFDFCFBFFEAE0DAFF9E847AFF774835FF663E36FF855944FFE8D9
                CFFFF7F0EDFFFCFAF9FFDFD4CEFF8A6657FF452D229A000000050805041D9F72
                5DF8E8DBD4FFE6D7CEFFCDB7AAFF8B6B5EFF7D4C3AFF865F56FF8B5F4BFFE9D8
                CEFFEADCD4FFCFB9ACFF997B6DFF966A54F70705041600000001000000076047
                3BA4D0B7ADFFEEE3DFFFD5C1B7FF93766CFF82533FFF734635FF926550FFECE0
                D9FFEBDED8FFC4B0A5FF9B7868FF5F45389D0000000400000000000000022219
                1541B89383FFF3EBE8FFD9C9C2FFA99389FFA67966FF00000026B48B76FFF0E7
                E3FFEADED9FFBDA79FFFA67D6CFF211915390000000100000000000000000000
                0007846554C6DDCCC4FFE6DCD8FFC2A99EFFA67E69F90000000CB38E79F8E0D1
                C9FFE9DFDAFFBCA497FF846555C2000000030000000000000000000000000000
                0002130F0D237D6152B7AF8673FA7B6050B9130E0C270000000414100E1E8365
                58B3B68F79F9806455B3130F0D1E000000010000000000000000000000000000
                0000000000010000000400000006000000050000000200000000000000000000
                0001000000010000000100000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000}
              TabOrder = 15
              OnClick = btnGridMostraOSClick
            end
            object mskDtNFRe: TMaskEditFocus
              Tag = 99
              Left = 347
              Top = 121
              Width = 78
              Height = 22
              CharCase = ecUpperCase
              EditMask = '99/99/9999'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              TabOrder = 22
              Text = '  /  /    '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = True
            end
            object edtNFReme: TEditFocus
              Tag = 99
              Left = 74
              Top = 121
              Width = 148
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 12
              TabOrder = 21
              OnKeyPress = edtNFRemeKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 12
              TipoTexto = ttNumerico
            end
            object mskDtRAnt: TMaskEditFocus
              Tag = 99
              Left = 282
              Top = 73
              Width = 63
              Height = 22
              CharCase = ecUpperCase
              EditMask = '99/99/9999'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              TabOrder = 14
              Text = '  /  /    '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = True
            end
            object edtObsGer: TMemoFocus
              Tag = 99
              Left = 74
              Top = 145
              Width = 461
              Height = 30
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 23
              OnExit = edtObsExit
              OnKeyDown = edtObsKeyDown
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              StringQuebra = '<<csq>>'
            end
            object edtObsNFS: TMemoFocus
              Tag = 99
              Left = 74
              Top = 177
              Width = 461
              Height = 30
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 24
              OnExit = edtObsExit
              OnKeyDown = edtObsKeyDown
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              StringQuebra = '<<csq>>'
            end
            object pnlImgEqu: TPanel
              Left = 540
              Top = 145
              Width = 130
              Height = 94
              BevelInner = bvLowered
              BorderWidth = 2
              BorderStyle = bsSingle
              Color = clWhite
              DoubleBuffered = True
              ParentBackground = False
              ParentDoubleBuffered = False
              TabOrder = 26
              OnDblClick = imgEquDblClick
              object lblErrImg: TLabel
                Left = 4
                Top = 4
                Width = 118
                Height = 48
                Align = alClient
                Alignment = taCenter
                Caption = 
                  'N'#227'o foi poss'#237'vel carregar a imagem do equipamento. Verifique o f' +
                  'ormato do arquivo!'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -9
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
                Layout = tlCenter
                Visible = False
                WordWrap = True
              end
              object imgEqu: TcxImage
                Left = 4
                Top = 4
                Align = alClient
                Properties.FitMode = ifmProportionalStretch
                Properties.PopupMenuLayout.MenuItems = []
                TabOrder = 0
                OnDblClick = imgEquDblClick
                Height = 82
                Width = 118
              end
            end
            object chkAutDescarte: TcxCheckBox
              Left = 500
              Top = 25
              Caption = 'Autoriza descarte das pe'#231'as?'
              TabOrder = 8
              OnClick = chkAutDescarteClick
            end
            object edtCodLoc: TEditFocus
              Tag = 99
              Left = 74
              Top = 25
              Width = 49
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 5
              TabOrder = 5
              OnEnter = edtCodLocEnter
              OnExit = edtCodLocExit
              OnKeyPress = edtCodLocKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesLoc: TEditFocus
              Left = 124
              Top = 25
              Width = 136
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              CharCase = ecUpperCase
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
          end
        end
      end
    end
    object pnlButtons: TPanel
      Left = 0
      Top = 605
      Width = 1360
      Height = 118
      Align = alBottom
      Anchors = []
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clGray
      ParentBackground = False
      TabOrder = 3
      object Panel3: TPanel
        Left = 2
        Top = 114
        Width = 1356
        Height = 0
        Align = alTop
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 3
        Visible = False
      end
      object FlwPnlButtons: TFlowPanel
        Left = 2
        Top = 2
        Width = 1356
        Height = 112
        Align = alTop
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 0
        object btnConfirmar: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 143
          Height = 22
          Caption = '[F10] Confirmar'
          TabOrder = 0
          OnClick = btnConfirmarClick
        end
        object btnConfirmarVarias: TBitBtnLocked
          Left = 143
          Top = 0
          Width = 143
          Height = 22
          Caption = '[Ctrl+F10] Confirmar V'#225'rias'
          TabOrder = 1
          Visible = False
          OnClick = btnConfirmarVariasClick
        end
        object btnRealizada: TBitBtnLocked
          Left = 286
          Top = 0
          Width = 143
          Height = 22
          Caption = '[F8] Realizada'
          Enabled = False
          TabOrder = 2
          OnClick = btnRealizadaClick
        end
        object btnImprimir: TBitBtnLocked
          Left = 429
          Top = 0
          Width = 143
          Height = 22
          Caption = '[F6] Imprimir'
          Enabled = False
          TabOrder = 3
          OnClick = btnImprimirClick
        end
        object btnTermoDev: TBitBtnLocked
          Left = 572
          Top = 0
          Width = 143
          Height = 22
          Caption = '[F4] Termo Dev.'
          Enabled = False
          TabOrder = 4
          OnClick = btnImprimirClick
        end
        object btnAlteracao: TBitBtnLocked
          Left = 715
          Top = 0
          Width = 143
          Height = 22
          Caption = '[F2] Altera'#231#227'o'
          TabOrder = 5
          OnClick = btnAlteracaoClick
        end
        object btnEndEnt: TBitBtnLocked
          Left = 858
          Top = 0
          Width = 143
          Height = 22
          Caption = '[Alt+F2] End. Entrega'
          TabOrder = 6
          OnClick = btnEndEntClick
        end
        object btnImpSeparacao: TBitBtnLocked
          Left = 1001
          Top = 0
          Width = 143
          Height = 22
          Caption = '[Alt+F12] Imp. Separa'#231#227'o'
          TabOrder = 7
          Visible = False
          OnClick = btnImpSeparacaoClick
        end
        object btnDesEsp: TBitBtnLocked
          Left = 1144
          Top = 0
          Width = 143
          Height = 22
          Caption = '[Ctrl+F4] Desc. Especial'
          TabOrder = 8
          OnClick = btnDesEspClick
        end
        object btnReprovar: TBitBtnLocked
          Left = 0
          Top = 22
          Width = 143
          Height = 22
          Caption = '[Alt+F5] Reprovar'
          Enabled = False
          TabOrder = 9
          OnClick = btnReprovarClick
        end
        object btnAprovada: TBitBtnLocked
          Left = 143
          Top = 22
          Width = 143
          Height = 22
          Caption = '[F9] Aprova'#231#227'o'
          Enabled = False
          TabOrder = 10
          OnClick = btnAprovadaClick
        end
        object btnCancelar: TBitBtnLocked
          Left = 286
          Top = 22
          Width = 143
          Height = 22
          Caption = '[F7] Cancelar OS'
          Enabled = False
          TabOrder = 11
          OnClick = btnCancelarClick
        end
        object btnObservacao: TBitBtnLocked
          Left = 429
          Top = 22
          Width = 143
          Height = 22
          Caption = '[F5] Observa'#231#227'o'
          Enabled = False
          TabOrder = 12
          OnClick = btnObservacaoClick
        end
        object btnManutencao: TBitBtnLocked
          Left = 572
          Top = 22
          Width = 143
          Height = 22
          Caption = '[F11] Em Manuten'#231#227'o'
          Enabled = False
          TabOrder = 13
          OnClick = btnManutencaoClick
        end
        object btnApontHoras: TBitBtnLocked
          Left = 715
          Top = 22
          Width = 143
          Height = 22
          Caption = '[Alt+F10] Apont. Horas'
          TabOrder = 14
          OnClick = btnApontHorasClick
        end
        object btnHisSta: TBitBtnLocked
          Left = 858
          Top = 22
          Width = 143
          Height = 22
          Caption = '[Alt+F3] Hist'#243'rico Status'
          TabOrder = 15
          OnClick = btnHisStaClick
        end
        object btnImpPed: TBitBtnLocked
          Left = 1001
          Top = 22
          Width = 143
          Height = 22
          Caption = '[Alt+F11] Imp. Pedido'
          TabOrder = 16
          Visible = False
          OnClick = btnImpPedClick
        end
        object btnSalRes: TBitBtnLocked
          Left = 1144
          Top = 22
          Width = 143
          Height = 22
          Caption = '[Ctrl+F7] Cons. Sal. Res.'
          TabOrder = 17
          OnClick = btnSalResClick
        end
        object btnImpostos: TBitBtnLocked
          Left = 0
          Top = 44
          Width = 143
          Height = 22
          Caption = '[Ctrl+F5] Impostos'
          TabOrder = 18
          OnClick = btnImpostosClick
        end
        object btnAddObsTec: TBitBtnLocked
          Left = 143
          Top = 44
          Width = 143
          Height = 22
          Caption = '[Alt+F6] Obs. T'#233'cnicas'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 19
          OnClick = btnAddObsTecClick
        end
        object btnDevCli: TBitBtnLocked
          Left = 286
          Top = 44
          Width = 143
          Height = 22
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Caption = '[F3] Devolver ao Cliente'
          Enabled = False
          NumGlyphs = 2
          TabOrder = 20
          Visible = False
          OnClick = btnDevCliClick
        end
        object btnImpEti: TBitBtnLocked
          Left = 429
          Top = 44
          Width = 143
          Height = 22
          Caption = '[Alt+F7] Imp. Etiquetas'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 21
          OnClick = btnImpEtiClick
        end
        object btnConsultaCatalogos: TBitBtnLocked
          Left = 572
          Top = 44
          Width = 143
          Height = 22
          Caption = '[Alt+F9] Cons. Cat'#225'logos'
          TabOrder = 22
          OnClick = btnConsultaCatalogosClick
        end
        object btnCancelarOS: TBitBtnLocked
          Left = 715
          Top = 44
          Width = 143
          Height = 22
          Caption = '[Alt+F8] Canc. OS Realizada'
          TabOrder = 23
          Visible = False
          OnClick = btnCancelarOSClick
        end
        object btnPedCompraItens: TBitBtnLocked
          Left = 858
          Top = 44
          Width = 286
          Height = 22
          Caption = '[F12] Informar PD de Compra dos Itens'
          TabOrder = 24
          Visible = False
          OnClick = btnPedCompraItensClick
        end
        object btnReativar: TBitBtnLocked
          Left = 1144
          Top = 44
          Width = 143
          Height = 22
          Caption = '[F1] Reativar'
          Enabled = False
          TabOrder = 25
          OnClick = btnReativarClick
        end
        object btnUltimasVendas: TBitBtnLocked
          Left = 0
          Top = 66
          Width = 143
          Height = 22
          Caption = '[ Shift+F8] '#218'ltimas Vendas'
          TabOrder = 26
          OnClick = btnUltimasVendasClick
        end
        object btnComunicacaoInterna: TBitBtnLocked
          Left = 143
          Top = 66
          Width = 143
          Height = 22
          Caption = '[Shift+F6] Com. Interna'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 27
          OnClick = btnComunicacaoInternaClick
        end
        object btnConsultarCliente: TBitBtnLocked
          Left = 286
          Top = 66
          Width = 143
          Height = 22
          Caption = 'Consultar Cliente'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 28
          OnClick = btnConsultarClienteClick
        end
        object btnImpItensServicos: TBitBtnLocked
          Left = 429
          Top = 66
          Width = 143
          Height = 22
          Caption = '[Ctrl+F8] Imp. Itens/Servi'#231'os'
          Enabled = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 29
          OnClick = btnImpItensServicosClick
        end
        object btnAltCondPagto: TBitBtnLocked
          Left = 572
          Top = 66
          Width = 143
          Height = 22
          Caption = '[Ctrl+F2] Alterar Cond. Pagto'
          TabOrder = 30
          Visible = False
          OnClick = btnAltCondPagtoClick
        end
        object btnAltTecServicos: TBitBtnLocked
          Left = 715
          Top = 66
          Width = 143
          Height = 22
          Caption = '[Ctrl+F3] Alterar T'#233'c. Serv.'
          TabOrder = 31
          Visible = False
          OnClick = btnAltTecServicosClick
        end
        object btnOrdMaoObrCli: TBitBtnLocked
          Left = 858
          Top = 66
          Width = 286
          Height = 22
          Caption = '[Ctrl+F12] Informar Ordem M'#227'o de Obra do Cliente'
          TabOrder = 32
          Visible = False
          OnClick = btnOrdMaoObrCliClick
        end
        object btnMostraMargem: TBitBtnLocked
          Left = 1144
          Top = 66
          Width = 143
          Height = 22
          Caption = '[Shift+F4] Margem/Lucro'
          TabOrder = 33
          OnClick = btnMostraMargemClick
        end
        object btnAlteraItens: TBitBtnLocked
          Left = 0
          Top = 88
          Width = 143
          Height = 22
          Caption = '[Ctrl+F6] Brinde Total Prod.'
          Enabled = False
          TabOrder = 34
          OnClick = btnAlteraItensClick
        end
        object btnBrindeTotalServ: TBitBtnLocked
          Left = 143
          Top = 88
          Width = 143
          Height = 22
          Caption = '[Ctrl+F9] Brinde Total Serv.'
          Enabled = False
          TabOrder = 35
          OnClick = btnBrindeTotalServClick
        end
        object btnCancAprovacao: TBitBtnLocked
          Left = 286
          Top = 88
          Width = 143
          Height = 22
          Caption = '[Shift+F9] Canc. Aprova'#231#227'o'
          Enabled = False
          TabOrder = 36
          OnClick = btnCancAprovacaoClick
        end
      end
      object btnFechar: TBitBtnLocked
        AlignWithMargins = True
        Left = 1273
        Top = 92
        Width = 82
        Height = 22
        Margins.Left = 14
        Margins.Top = 1
        BiDiMode = bdLeftToRight
        Caption = '&Sair'
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000120B0000120B0000000100000001000000520000006B
          0000006B0800106B0800008C080000940800007B100000731800087B180008A5
          1800089C21001094290010A529001084310010A5310018A5310010A539001884
          4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
          4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
          5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
          AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
          BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
          CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
          D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
          DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
          F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
          FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
          FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
          5959595959595959595932514E32323232325959595959595959325266655F5F
          5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
          1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
          21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
          44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
          372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
          4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
          6A4A231B59595959595959592626262626262359595959595959}
        ParentBiDiMode = False
        TabOrder = 2
        OnClick = btnSairClick
      end
      object chkAg_Mon: TCheckBox
        Left = 1135
        Top = 91
        Width = 124
        Height = 22
        ParentCustomHint = False
        BiDiMode = bdLeftToRight
        Caption = 'Aguard. Montagem'
        Color = clGray
        Ctl3D = True
        DoubleBuffered = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentColor = False
        ParentCtl3D = False
        ParentDoubleBuffered = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        Visible = False
        StyleElements = []
        OnClick = chkAg_MonClick
      end
    end
    object pnlTotal: TPanel
      Left = 0
      Top = 530
      Width = 1360
      Height = 75
      Align = alBottom
      ParentBackground = False
      ParentColor = True
      TabOrder = 2
      DesignSize = (
        1360
        75)
      object lblLegTotGer: TLabel
        Left = 1175
        Top = 53
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total Geral:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 833
      end
      object lblLegTotPro: TLabel
        Left = 1153
        Top = 2
        Width = 83
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total Produtos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 811
      end
      object lblLegTotSer: TLabel
        Left = 1156
        Top = 19
        Width = 80
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total Servi'#231'os:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 814
      end
      object Label6: TLabel
        Left = 28
        Top = 5
        Width = 113
        Height = 14
        Alignment = taRightJustify
        Caption = 'Previs'#227'o de Entrega:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 5
        Top = 23
        Width = 136
        Height = 14
        Alignment = taRightJustify
        Caption = 'Condi'#231#227'o de Pagamento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 21
        Top = 57
        Width = 120
        Height = 14
        Alignment = taRightJustify
        Caption = 'Forma de Pagamento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblEntreg: TLabel
        Left = 147
        Top = 4
        Width = 62
        Height = 15
        Caption = '99/99/9999'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCodCnd: TLabel
        Left = 147
        Top = 22
        Width = 409
        Height = 15
        Caption = '999-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblConPag: TLabel
        Left = 147
        Top = 38
        Width = 310
        Height = 15
        Caption = '(99) 999.999.999.999.999.999.999.999.999.999.999.999'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblForPag: TLabel
        Left = 148
        Top = 56
        Width = 409
        Height = 15
        Caption = '999-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotPro: TLabel
        Left = 1315
        Top = 0
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 973
      end
      object lblTotSer: TLabel
        Left = 1315
        Top = 17
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 973
      end
      object lblTotGer: TLabel
        Left = 1315
        Top = 51
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 973
      end
      object lblLegTotDes: TLabel
        Left = 1152
        Top = 36
        Width = 84
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total Desconto:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 810
      end
      object lblTotDes: TLabel
        Left = 1315
        Top = 34
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 973
      end
      object lblST: TLabel
        Left = 960
        Top = 2
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total ST:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
        ExplicitLeft = 618
      end
      object lblIPI: TLabel
        Left = 960
        Top = 19
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total IPI:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
        ExplicitLeft = 618
      end
      object lblTotIPI: TLabel
        Left = 1083
        Top = 17
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
        ExplicitLeft = 741
      end
      object lblTotST: TLabel
        Left = 1083
        Top = 0
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
        ExplicitLeft = 741
      end
      object lblFre: TLabel
        Left = 944
        Top = 36
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total Frete:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
        ExplicitLeft = 602
      end
      object lblTotFre: TLabel
        Left = 1083
        Top = 34
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
        ExplicitLeft = 741
      end
      object lblTotRef: TLabel
        Left = 1083
        Top = 51
        Width = 38
        Height = 22
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lblRef: TLabel
        Left = 948
        Top = 53
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'IBS/CBS/IS:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
    end
    object pnlTabs: TPanel
      Left = 0
      Top = 331
      Width = 1360
      Height = 199
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 1
      object pgcTabs: TPageControl
        Left = 0
        Top = 0
        Width = 1360
        Height = 199
        ActivePage = tbsAcessorios
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        TabStop = False
        StyleElements = [seFont, seBorder]
        OnChanging = pgcTabsChanging
        object tbsAcessorios: TTabSheet
          Caption = '[CTRL+A] Acess'#243'rios'
          ImageIndex = 4
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlAcessorios: TPanel
            Left = 0
            Top = 0
            Width = 1352
            Height = 60
            Align = alTop
            Enabled = False
            ParentColor = True
            TabOrder = 0
            DesignSize = (
              1352
              60)
            object lblAcessorio: TLabel
              Left = 18
              Top = 11
              Width = 53
              Height = 14
              Alignment = taRightJustify
              Caption = 'Acess'#243'rio:'
            end
            object lblQtdAce: TLabel
              Left = 13
              Top = 36
              Width = 58
              Height = 14
              Alignment = taRightJustify
              Caption = 'Quantidade:'
            end
            object btnCancelaAce: TBitBtnLocked
              Left = 1256
              Top = 32
              Width = 95
              Height = 22
              Anchors = [akTop, akRight]
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
              TabOrder = 4
              OnClick = btnCancelaAceClick
            end
            object btnAdicionarAce: TBitBtnLocked
              Left = 1155
              Top = 32
              Width = 95
              Height = 22
              Anchors = [akTop, akRight]
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
              TabOrder = 3
              OnClick = btnAdicionarAceClick
            end
            object edtCodAce: TEditFocus
              Tag = 99
              Left = 73
              Top = 7
              Width = 65
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 5
              TabOrder = 0
              OnEnter = edtCodEquEnter
              OnExit = edtCodEquExit
              OnKeyPress = edtCodAceKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesAce: TEditFocus
              Left = 137
              Top = 7
              Width = 1207
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Anchors = [akLeft, akTop, akRight]
              CharCase = ecUpperCase
              Color = 16768952
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
            object edtQtdAce: TEditFocus
              Tag = 99
              Left = 73
              Top = 32
              Width = 64
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
          object dbgGridAce: TDBGridCitel
            Left = 0
            Top = 60
            Width = 1352
            Height = 107
            Align = alClient
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            ReadOnly = True
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = 14
            TitleFont.Name = 'Arial'
            TitleFont.Pitch = fpVariable
            TitleFont.Style = []
            OnDblClick = dbgGridAceDblClick
            OnKeyDown = dbgGridAceKeyDown
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'CODACE'
                Title.Caption = 'C'#243'd. Acess'#243'rio'
                Width = 81
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DESACE'
                Title.Caption = 'Descri'#231#227'o'
                Width = 893
                Visible = True
              end
              item
                Alignment = taRightJustify
                Expanded = False
                FieldName = 'QTDACE'
                Title.Caption = 'Quantidade'
                Visible = True
              end>
          end
        end
        object tbsDefeitos: TTabSheet
          Caption = '[CTRL+D] Defeitos'
          ImageIndex = 2
          object dbgGridDfe: TDBGridCitel
            Left = 0
            Top = 60
            Width = 1352
            Height = 107
            Align = alClient
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            ReadOnly = True
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = 14
            TitleFont.Name = 'Arial'
            TitleFont.Pitch = fpVariable
            TitleFont.Style = []
            OnKeyDown = dbgGridDfeKeyDown
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'CODDFE'
                Title.Caption = 'C'#243'd. Defeito'
                Width = 67
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DESDFE'
                Title.Caption = 'Descri'#231#227'o'
                Width = 908
                Visible = True
              end>
          end
          object pnlDefeitos: TPanel
            Left = 0
            Top = 0
            Width = 1352
            Height = 60
            Align = alTop
            Enabled = False
            ParentColor = True
            TabOrder = 0
            DesignSize = (
              1352
              60)
            object Label34: TLabel
              Left = 34
              Top = 11
              Width = 37
              Height = 14
              Alignment = taRightJustify
              Caption = 'Defeito:'
            end
            object btnCancelaDfe: TBitBtnLocked
              Left = 1251
              Top = 32
              Width = 95
              Height = 22
              Anchors = [akTop, akRight]
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
              TabOrder = 3
              OnClick = btnCancelaDfeClick
            end
            object btnAdicionarDfe: TBitBtnLocked
              Left = 1155
              Top = 32
              Width = 95
              Height = 22
              Anchors = [akTop, akRight]
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
              TabOrder = 2
              OnClick = btnAdicionarDfeClick
            end
            object edtCodDfe: TEditFocus
              Tag = 99
              Left = 74
              Top = 7
              Width = 65
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 5
              TabOrder = 0
              OnEnter = edtCodEquEnter
              OnExit = edtCodEquExit
              OnKeyPress = edtCodDfeKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtDesDfe: TEditFocus
              Left = 139
              Top = 7
              Width = 1207
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Anchors = [akLeft, akTop, akRight]
              CharCase = ecUpperCase
              Color = 16768952
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
        object tbsProdutos: TTabSheet
          Caption = '[CTRL+P] Produtos'
          object dbgGrid: TDBGridCitel
            Left = 0
            Top = 68
            Width = 1352
            Height = 41
            Align = alClient
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = 14
            TitleFont.Name = 'Arial'
            TitleFont.Pitch = fpVariable
            TitleFont.Style = []
            OnCellClick = dbgGridCellClick
            OnDrawColumnCell = dbgGridDrawColumnCell
            OnDblClick = dbgGridDblClick
            OnKeyDown = dbgGridKeyDown
            OnMouseMove = dbgGridMouseMove
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'CODITE'
                Title.Caption = 'C'#243'd. Item'
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
                FieldName = 'ENTRET'
                Title.Caption = 'Ent.'
                Width = 23
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DESMAR'
                Title.Caption = 'Marca'
                Width = 117
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'REFERE'
                Title.Caption = 'Refer'#234'ncia'
                Width = 136
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'COPREF'
                Title.Caption = ' '
                Width = 20
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CODFAB'
                Title.Caption = 'C'#243'd. F'#225'brica'
                Width = 104
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'COPCFB'
                Title.Caption = ' '
                Width = 20
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'UNIDAD'
                Title.Caption = 'Unid.'
                Width = 35
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TABPRE'
                Title.Caption = 'TP'
                Width = 20
                Visible = True
              end
              item
                Alignment = taRightJustify
                Expanded = False
                FieldName = 'QTDITE'
                Title.Alignment = taRightJustify
                Title.Caption = 'Quant.'
                Width = 55
                Visible = True
              end
              item
                Alignment = taRightJustify
                Expanded = False
                FieldName = 'UNITAR'
                Title.Alignment = taRightJustify
                Title.Caption = 'Vlr. Unit'#225'rio'
                Width = 65
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DESESP'
                Title.Caption = 'Desc. Esp.'
                Visible = True
              end
              item
                Alignment = taRightJustify
                Expanded = False
                FieldName = 'VLRCON'
                Title.Alignment = taRightJustify
                Title.Caption = 'Vlr. Total'
                Width = 65
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VALIPI'
                Title.Caption = 'Valor IPI'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VALRET'
                Title.Caption = 'Val. ST'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VALCBS'
                Title.Caption = 'Val. CBS'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VALIBS'
                Title.Caption = 'Val. IBS'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VAL_IS'
                Title.Caption = 'Val. IS'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'EMPITE'
                Title.Caption = 'Emp.'
                Width = 30
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'AGUARD'
                Title.Caption = 'Sal. Disp. Loj.'
                Width = 70
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SALDIS'
                Title.Caption = 'Sal. Disp. OS'
                Width = 66
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ABRSAL'
                Title.Caption = ' '
                Width = 20
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'BRINDE'
                Title.Caption = 'Brinde?'
                Width = 42
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TIPBRI'
                Title.Caption = 'Tipo Brinde'
                Width = 60
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PROMOC'
                Title.Alignment = taCenter
                Title.Caption = 'Situa'#231#227'o'
                Width = 50
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'COBAPA'
                Title.Caption = #192' Parte'
                Visible = False
              end>
          end
          object pnlItens: TPanel
            Left = 0
            Top = 0
            Width = 1352
            Height = 68
            Align = alTop
            Enabled = False
            ParentBackground = False
            ParentColor = True
            TabOrder = 1
            object pnlItensTop: TPanel
              Left = 1
              Top = 1
              Width = 1350
              Height = 39
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
              object Label5: TLabel
                Left = 49
                Top = 21
                Width = 22
                Height = 14
                Alignment = taRightJustify
                Caption = 'Item:'
              end
              object Label26: TLabel
                Left = 823
                Top = 21
                Width = 51
                Height = 14
                Alignment = taRightJustify
                AutoSize = False
                Caption = 'Unidade:'
              end
              object lblTabPrecoItem: TLabel
                Left = 928
                Top = 21
                Width = 51
                Height = 14
                Caption = 'Tab.Pre'#231'o:'
                Visible = False
              end
              object rdbCodIte: TRadioButton
                Left = 190
                Top = 2
                Width = 96
                Height = 14
                Caption = 'C'#243'digo do Item'
                Checked = True
                TabOrder = 0
                TabStop = True
                OnClick = rdbCodIteClick
              end
              object rdbCodFab: TRadioButton
                Left = 73
                Top = 2
                Width = 113
                Height = 14
                Caption = 'C'#243'digo da F'#225'brica'
                TabOrder = 1
                OnClick = rdbCodFabClick
              end
              object edtCodIte: TEditFocus
                Tag = 99
                Left = 72
                Top = 17
                Width = 71
                Height = 22
                Alignment = taLeftJustify
                CharCase = ecUpperCase
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 5
                TabOrder = 2
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
                Left = 146
                Top = 17
                Width = 672
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                CharCase = ecUpperCase
                Color = 16768952
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 57
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
              object edtUnidad: TEditFocus
                Tag = 99
                Left = 876
                Top = 17
                Width = 38
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                CharCase = ecUpperCase
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 2
                ReadOnly = True
                TabOrder = 4
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttAlfanumerico
              end
              object cbTabPrecoItem: TComboBoxFocus
                Tag = 99
                Left = 980
                Top = 17
                Width = 38
                Height = 22
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 1
                Sorted = True
                TabOrder = 5
                OnExit = cbTabPrecoItemExit
                OnKeyPress = cbTabPrecoItemKeyPress
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
              end
              object pnlEmpIte: TPanel
                Left = 1029
                Top = 6
                Width = 321
                Height = 35
                BevelOuter = bvNone
                TabOrder = 6
                object lblEmpIte: TLabel
                  Left = 4
                  Top = 15
                  Width = 23
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'Emp:'
                end
                object edtEmpIte: TEditFocus
                  Tag = 99
                  Left = 28
                  Top = 11
                  Width = 31
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
                  TabOrder = 0
                  OnKeyPress = edtEmpIteKeyPress
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = True
                  TamCampo = 3
                  TipoTexto = ttInteiro
                end
                object edtDesEmpIte: TEditFocus
                  Left = 60
                  Top = 11
                  Width = 257
                  Height = 22
                  TabStop = False
                  Alignment = taLeftJustify
                  CharCase = ecUpperCase
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
            end
            object pnlItensBottom: TPanel
              Left = 1
              Top = 40
              Width = 1350
              Height = 27
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              object pnlDestino: TPanel
                Left = 0
                Top = 0
                Width = 147
                Height = 27
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
                object lblEntRet: TLabel
                  Left = 32
                  Top = 5
                  Width = 39
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'Destino:'
                end
                object cmbEntRet: TComboBoxFocus
                  Tag = 99
                  Left = 72
                  Top = 2
                  Width = 71
                  Height = 22
                  Style = csDropDownList
                  Color = clWhite
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlue
                  Font.Height = 14
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  ImeName = 'Portugu'#234's (Brasil ABNT)'
                  ItemIndex = 1
                  ParentFont = False
                  TabOrder = 0
                  Text = 'RETIRA'
                  OnChange = cmbEntRetChange
                  Items.Strings = (
                    'ENTREGA'
                    'RETIRA')
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                end
              end
              object pnlLocRet: TPanel
                Left = 147
                Top = 0
                Width = 210
                Height = 27
                Align = alLeft
                BevelOuter = bvNone
                Color = 16770261
                ParentBackground = False
                TabOrder = 1
                object lblLocRet: TLabel
                  Left = 4
                  Top = 5
                  Width = 60
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'Local Retira:'
                end
                object cmbLocRet: TComboBoxFocus
                  Tag = 99
                  Left = 64
                  Top = 2
                  Width = 138
                  Height = 22
                  Style = csDropDownList
                  Color = clWhite
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clRed
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = []
                  ImeName = 'Portugu'#234's (Brasil ABNT)'
                  ParentFont = False
                  TabOrder = 0
                  OnChange = cmbLocRetChange
                  Items.Strings = (
                    'CAIXA'
                    'EXPEDI'#199#195'O'
                    'BALC'#195'O'
                    'BALC'#195'O 2')
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                end
              end
              object pnlItensValores: TPanel
                Left = 357
                Top = 0
                Width = 993
                Height = 27
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 2
                object Label9: TLabel
                  Left = 2
                  Top = 5
                  Width = 58
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'Quantidade:'
                end
                object Label12: TLabel
                  Left = 139
                  Top = 5
                  Width = 58
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'Vlr. Unitario:'
                end
                object Label15: TLabel
                  Left = 276
                  Top = 5
                  Width = 25
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'Total:'
                end
                object edtQtdIte: TEditFocus
                  Tag = 99
                  Left = 60
                  Top = 2
                  Width = 65
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
                  TabOrder = 0
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = False
                  TamCampo = 0
                  TipoTexto = ttNumerico
                  EditFormat = '#,##0.00'
                end
                object edtUnitar: TEditFocus
                  Tag = 99
                  Left = 199
                  Top = 2
                  Width = 65
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
                  TabOrder = 1
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = False
                  TamCampo = 0
                  TipoTexto = ttNumerico
                  EditFormat = '#,####0.0000'
                end
                object btnCancelaItem: TBitBtnLocked
                  Left = 900
                  Top = 2
                  Width = 89
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
                  TabOrder = 7
                  OnClick = btnCancelaItemClick
                end
                object btnAdicionar: TBitBtnLocked
                  Left = 808
                  Top = 2
                  Width = 86
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
                  TabOrder = 6
                  OnClick = btnAdicionarClick
                end
                object edtTotIte: TEditFocus
                  Tag = 99
                  Left = 303
                  Top = 2
                  Width = 90
                  Height = 22
                  TabStop = False
                  Alignment = taRightJustify
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
                  TabOrder = 2
                  NormalColor = 16768952
                  FocusColor = clSilver
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = False
                  TamCampo = 0
                  TipoTexto = ttNumerico
                end
                object chkBrindePro: TCheckBox
                  Left = 406
                  Top = 5
                  Width = 66
                  Height = 17
                  Caption = 'Brinde?'
                  TabOrder = 3
                  OnClick = chkBrindeProClick
                end
                object pnlTipBriPrd: TPanel
                  Left = 471
                  Top = 2
                  Width = 220
                  Height = 25
                  BevelOuter = bvNone
                  TabOrder = 4
                  Visible = False
                  object lblTipBriPrd: TLabel
                    Left = 3
                    Top = 5
                    Width = 72
                    Height = 14
                    Alignment = taRightJustify
                    Caption = 'Tipo de Brinde:'
                  end
                  object clbTipBriPrd: TColorLabel
                    Left = 105
                    Top = 5
                    Width = 100
                    Height = 14
                    Caption = '(G)arantia (C)ortesia'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clBlack
                    Font.Height = 14
                    Font.Name = 'Arial'
                    Font.Pitch = fpVariable
                    Font.Style = []
                    ParentFont = False
                    CorDestaque = clRed
                  end
                  object edtTipBriPrd: TEditFocus
                    Tag = 99
                    Left = 77
                    Top = 0
                    Width = 27
                    Height = 22
                    Alignment = taCenter
                    CharCase = ecUpperCase
                    ImeName = 'Portugu'#234's (Brasil ABNT)'
                    MaxLength = 1
                    TabOrder = 0
                    Text = 'G'
                    NormalColor = clWindow
                    FocusColor = clInfoBk
                    RequeridoColor = clRed
                    Requerido = False
                    CompZeros = False
                    TamCampo = 1
                    TipoTexto = ttAlfabetico
                  end
                end
                object chkCobAPa: TCheckBox
                  Left = 690
                  Top = 5
                  Width = 97
                  Height = 17
                  Caption = 'Cobrar '#224' Parte'
                  TabOrder = 5
                  Visible = False
                end
              end
            end
          end
          object pgbProgresso: TProgressBar
            Left = 0
            Top = 109
            Width = 1352
            Height = 10
            Align = alBottom
            Smooth = True
            TabOrder = 2
            Visible = False
          end
          object pnlBottomItens: TPanel
            Left = 0
            Top = 119
            Width = 1352
            Height = 32
            Align = alBottom
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 3
            StyleElements = [seFont, seBorder]
            object pnlDadosItem: TPanel
              Left = 1
              Top = -1
              Width = 1350
              Height = 32
              Align = alBottom
              Alignment = taLeftJustify
              BevelOuter = bvNone
              Color = clWhite
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
              StyleElements = [seFont, seBorder]
              object Label33: TLabel
                Left = 5
                Top = 1
                Width = 101
                Height = 14
                Caption = 'C'#243'digo de F'#225'brica:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl2: TLabel
                Left = 761
                Top = 1
                Width = 45
                Height = 14
                Caption = 'Em Falta'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object imgPecPen: TImage
                Left = 741
                Top = 0
                Width = 16
                Height = 16
                AutoSize = True
                Center = True
                Picture.Data = {
                  0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                  0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
                  4D410000B18F0BFC610500000016744558745469746C650054696D653B436C6F
                  636B3B57617463686F8838A80000037E49444154384F4D537F50D365187F09EA
                  FC91FD55E7A987B401929AA964971609C1369011F2C33B4585A3269724D952D2
                  C19D857654A069F2432FDD61C39BD7990519BA450E47E5AC3643E5B631C18D8D
                  1B04FB51720EC6AF3E3DEF37AEEB7BF7B9CFFBBCEFF3F9BCCFF3DCF765E1EE1B
                  02E88B204476BD7F60737755C519DB910A8BE3C3CA095B95CA72E750F9D9DF2A
                  9439741EC5F3C2774943306DCD66FF895B4A158BAD1FA8BE757EF61102BA4B08
                  FD6A002521F48B01FEAB17D177F4086EAB9497B545DB9650FE23E3B77F643F6D
                  91732D8B3028772FB755550C0F6ACF20D0FE352CE56F419F29416BD27A6229CC
                  650AF85A3518686A44D7FE3DC39AEDF9315CD799BB89B1AC78F19C3B07DFE9FA
                  E3E2390C684EE18A2405A69A63B09B6EC135F897C0376B8FE1AA2419AEFA6A32
                  6980A954D146068F7113D626971453BFF07DA7854E960ABBF10686822184C253
                  989EF91B63C43CB61B4DD0A5A762E8DC715E05BE4C4D2A268348A693A77DEF56
                  9F8445F926CC750D18F48704E1FF3F1E7BFD0F71ABBE1196DD85E8AB3D8456C9
                  2BED4215FAF414BFEF1B0DDAE552787A9CB82CDD844B4969D03EFF329A56BE00
                  65FA0E8C8D8731FCE7183C0E27AEC965F03656A33565C30819CC616DD28D08B6
                  68A04B4B4620F81081D1307AFAFAE1F60CC0EBF522BF5025C481D171F8E95C2F
                  7B1543F587E9921727C9602E6B497EC93FF4451DAE654931E274633434499898
                  E549E4EE3C080719F0F588CB838ED764705597E3C2FA445EC15CA6DDB0EE07EB
                  E10330EF2A404FB34618DE58785A181E474EC17BB8EF720B6BC7F966985FDF8A
                  DFCB8AA14E7CCE20B4D0B0F6D9527D5E26FA3F56A1232713BEEEBB989C9AC6C4
                  D48CC0D9DBF6A3DFED81DF6A85314F8EFB957BD022DB889AE5CB4AC8208AC53F
                  3E7F41D3DA5556F35E05ECFB7609253AD49FE3415F2F6668FA0F7A7B718F6263
                  7606EC7BDFC0CF3B7351B722414FE27904FEFBB3C87DA2A589EAD5AB463A77E4
                  A1B7BC04E6C27C183767A0234B82CE9C74988BF271EF5D050CB91938BD6299AF
                  70D1C204AE3BF54C3C6381AF34DC24AA60D1C2B81309717A9A096ED22DB6B78B
                  E124335B59114CDBB3D1BC6E0D6A6345ED5B9E7A9254FF3EAABA383163FE0B6A
                  C2596E1249985719135D52132BBA7E224E14A4041C178B829F8863AEABA297F0
                  9EE7CFE645F834A7D9A7627A122763C5B310D1BED0D3A304DEDF02C213B3CC63
                  BE1F71F4E9A54C404C34219AFD03F40537BB5805F5AC0000000049454E44AE42
                  6082}
                Transparent = True
              end
              object imgPecDis: TImage
                Left = 741
                Top = 16
                Width = 16
                Height = 16
                AutoSize = True
                Center = True
                Picture.Data = {
                  0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                  0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
                  4D410000B18F0BFC610500000021744558745469746C65004170706C793B4F4B
                  3B436865636B3B426172733B526962626F6E3B6463C868000003A64944415438
                  4F4D937D50D3751CC77FA2AB0CCE844EAD331B0339C6C38603EDCE23E80865E4
                  248ABA150B27D1648E8D1288A734E681131FB8AC29036CCB8C553320F0085C20
                  C822260F4D6C83C538509EDA788807818CFE7AF7FDCDBAEB77F7BAFBDD7D3FEF
                  D7E7F3B9FB7EA9C995066AEEA18922DF3AC2FA8C0BEC985C6DA8EE7835A75F69
                  085B507ECBED3FA1E7346495070BC9F963048FF9BFCC94EBCF1BD4D44A3D45B9
                  568DEE7052166B5BA63AC8585AB30FAD5615EC4E03E656BB30345303D3D059A8
                  9B0528F832B44F54E81748379A7D78EB91800E0BD299CF647C1A3C6C301DC3E4
                  721386972A3130AFC29DB95CD817CF6074590BD76A0B1A2D05C8D7716793F3FD
                  B824E731B15CE7166C78EF34BBA9CE5C00C7C26574FC7E049D2E09CC2E19BAA7
                  E5E89951A067568E66BB18BFCD57A0D5761A8ACF42ACDB777A7AD1CDA9A46C3F
                  FE716D2CEC7F94A3E5BE086D1362DC9A7A1726A7045D4E296E4F4B5174752F0E
                  64322139CF8663B11265B509385414904937A7DEFE28A0A6A13B1F37C7D27063
                  544824C9681B4F413B1199A60E435AC646DE27328C8C3BC1976FC30F4387D136
                  58823455A099083652C242FF91764701AE0F2741DD128518D946E469C360BCF7
                  1672AA3828D2E4C035BB04C599445C6E15E1C77BEFE0F6841269A5EC3522F0A2
                  DECCF35F363AD261B0C52146EA893EAB15F91732102BF7768727A71FE0FC57D9
                  507D1347A613A3DE71103F4DC8917A2A102191DECF52AF65FBDED7F70A60B0EE
                  83BA311119C5AFC239B384A6CE0E8C4E2E6260F40E1273B7C338928ADAA1787C
                  67E7A376E075883E0EA027D844252858CD658D51B862D98B6B83021457C7A2B8
                  428685076B5858F91B87947B70F567210C83B1D0DBA2A1FFF54594DF8CC11B39
                  2C0B1178522F8B7788D3CF71F185251215BDBB70CD264056F96EE8EA4B61EABF
                  8ED473FE64BDFDB8D2FF023EB744A0FA6E348E5DE2812F795E49048F13A82705
                  72DFBB27BEE6A2AA37029A6E2E59E720524A7C1129A5A069DF8FAA3E1E2A09DA
                  5F76A3A48E87C40F58362F1FC6D324EB410BD647C46FE52564FACD7FA80B2282
                  30687AB8644F219A868F424726D3F4EC22F27014EA439094E3BF161EB7258AE4
                  189D13EF5394695C464B18E1F15BF71C90F98EA49CDC89A2DA20A8BB4271A99B
                  838B660E4E7E1F8C5455005E39CA1CE03D0AD3A3AF73673BC624B4807E891BC8
                  583ED1C9CF15C6499866819C05370A16F84798D697443B4E793EC5D842EA1874
                  3D9D7367FFFBF95744EF44DBE97BBE99E043F0266C223C41F0F87F7DC79884FA
                  070244118F93E074F30000000049454E44AE426082}
                Transparent = True
              end
              object Label16: TLabel
                Left = 761
                Top = 16
                Width = 57
                Height = 14
                Caption = 'Dispon'#237'vel'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblCodFab: TLabel
                Left = 112
                Top = 0
                Width = 22
                Height = 15
                Caption = 'XYZ'
                Font.Charset = ANSI_CHARSET
                Font.Color = clMaroon
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblSaldos: TLabel
                Left = 117
                Top = 17
                Width = 24
                Height = 15
                Caption = '0,00'
                Font.Charset = ANSI_CHARSET
                Font.Color = clMaroon
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblDesSaldos: TLabel
                Left = 5
                Top = 18
                Width = 105
                Height = 14
                Caption = 'Saldo Disp. da Loja:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object imgSalInd: TImage
                Left = 836
                Top = 0
                Width = 16
                Height = 16
                AutoSize = True
                Center = True
                Picture.Data = {
                  0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                  0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
                  4D410000B18F0BFC61050000000F744558745469746C65005461736B3B456469
                  74B88F66B30000031E49444154384F65937F2C94711CC71F271CE362FD519B96
                  B56CD5F28FB5B27E4D086148CA12D54A44FA31B55A53A1AC8CF3A32E154A8A75
                  95D41695893952295D762EBFD2313FFA817338BFEE1C77EF3ECF336EAD9EEDB5
                  3DFB3EDFD7EBFBECFB7C1F0600439709614A2C20CC12335F562765BD020BDD23
                  21BD5442E3E673B0734C588F73E702A6DF0BF6D5280AC2A1B8178A848C32F40E
                  A8F141DE8B3A590F22E272D170D5034D193E90A66EAB6523FF06CC3AEF876146
                  F5053D253148CE2CC1BE63D9083F2AC2DEE8EB88399B879A8B5BD02E8E44ED85
                  0DAC60F16FC0BC237F0F74CA06743F89828106CBAB65C829AC44EE834AE41075
                  97B6E23B3D7B7BDE8515F8FF05BEE5EDC6F4C07B74890FC16030403D310D45CF
                  20EABF2838A4426F743D3B321FB07C97B691A94A5C670C58B4E50463FAB7048A
                  A2FDD0EB0D181DD77274FF5441D6DA4B014FFCAA4CC4E76B7B58C1866037DDC4
                  1868CDDE01CD8F37E828A0BD98D563784CCBA11AD3A0AF7F14CDF911F8559781
                  7799FEA095F1F8B8530A79E6F301FE57913F34DDA568BF1B02DD8C9E1387D41A
                  A88811BA6F159F82ACE810142F76416FE842B33810A2A065A9F3014B79962F26
                  3B9FA23537185ADD2CC953181A9DC23005FA55A3A8BF19828EE7419CACED3C41
                  7BE104E1B625733B490159BA1726BE15A1E57620A6B4335092CC46FA9523682C
                  CB405B7100274F3447A3FACC2A540B5D11E76C9B351FB06A4CF5C078CB5D348B
                  7C31AED14149F2EF8161485F08D1F2D08F93471A0EA2EAA4232A923721D64920
                  22CFDA18905E71C558D30DC8AF79417E2310F2C258BCBDBE13F2026F4E1E9084
                  A2227639CACEAFC7E195D6D9E4B05F82670C34246F865A9A06654514066BE2F1
                  A9381E75C2ED9CDCF73208E5D10E787EDA19075658DDA2F90B59397431FD1A73
                  010B49BC8BE4C3C575781FBF16F5E93B713A3206A5792998ECFB88D7510E781C
                  BB06610E96B769AE2D2B773EF26182179919033C824F5813ECABD93B7B9EE992
                  D757A030F51C2EBB3922C49E9F43E37604AFED8E3BD376C78D09B0A5B3C406FE
                  A62A898E27AD62B7D41D82C52EBD5676ABF3EC05D69E342660653F8129C3E26B
                  C3637C6C78CC1F61784C65A970C7B70000000049454E44AE426082}
                Transparent = True
                Visible = False
              end
              object lblSalInd: TLabel
                Left = 856
                Top = 1
                Width = 98
                Height = 14
                Caption = 'Saldo Insuficiente'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
                Visible = False
              end
              object Label35: TLabel
                Left = 349
                Top = 18
                Width = 60
                Height = 14
                Caption = 'Loc. Fisica:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl_LocFis: TLabel
                Left = 415
                Top = 17
                Width = 28
                Height = 15
                Caption = '0000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clMaroon
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label36: TLabel
                Left = 541
                Top = 18
                Width = 110
                Height = 14
                Caption = 'Loc. Fisica Sup. Est.:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lbl_LocSup: TLabel
                Left = 655
                Top = 17
                Width = 28
                Height = 15
                Caption = '0000'
                Font.Charset = ANSI_CHARSET
                Font.Color = clMaroon
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object imgCopCFB: TImage
                Left = 635
                Top = 0
                Width = 16
                Height = 16
                AutoSize = True
                Center = True
                Picture.Data = {
                  0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                  0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
                  4D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA86400
                  00028549444154384F7592494F5351188689BAD0288EFFC385BA312E8C61438C
                  0B121364102D549B88256D299314840A9A12B00C4A70880B2960092250696FA5
                  2DC60041448D0360A0D168C2D0822DA5D091B6AFDFB9174C80F44D9ED53DCFFB
                  7DE7E4266C8FBAC16453379A50D9604285D688F23A03146ABD6DE373FCCC7466
                  D8DE369C27A91F0BAE5598C77EC1F8FE270CC37688E42D78A53A83495D6AFCA2
                  697D3A16EC56149668912D7F8ACCDC8748BD568F942C0DC4D755F86E6DC1B036
                  191BC777E6477B1A82AE717C3128C1355D02F7200D03CDE9B03DCEC4982E0713
                  3D3760A93E17BF60E2792A229E71047F37C3397E07D35C3EA1C00C2787DD4C70
                  3258EE26B1827D1BEC25761142BE3EBB8875D70802F67A78276B507EDF86B23A
                  0B54B503B855F306C544918643C13D1394554628AA5E6F9609F9F4280561E720
                  FC531AB83FAB49B4205EC2912864EA3E567040B0291F9A2E203C6FC2DA373596
                  C64A51A231F3873DBE30967D211EF75A08AED510FE12D2DB3DAC2051B02923B5
                  C908FEE986F763299C434A14D1AA2CEE2D62104B5E4600B9A52F59C141C1A6BC
                  AB4E82DFDE869551251C835228ABFB11630524F2B237C4CB8B2B01383D01488A
                  BB58C121C1A658CBCFC237F5049E2129E6CC12C82B0D88C662FFA7F222E120D9
                  B11C80B850CF0A0E0B36C55C749AEEDF08F7A004B34611F22A7A1189C6B048EB
                  3A5782FC5487C78F85653FE609517E072B3822D81483EC14D7273D89DE9B27D0
                  213E8EDCB26EFEB5053140228364B71F736E1FB2646DACE0A860EF4CA2A4A40B
                  C1F528BF2E9BB829CEBA042EE7E958C131E1F8CEEC17177622A7408FECFC17B8
                  AA68C715793B4DD5F162665E2B32A4AD5B1F715B7613EC27618FC4EEC960EB32
                  D854067D4BD8F30F79C8130B115666270000000049454E44AE426082}
                Transparent = True
                Visible = False
              end
              object lblSal_OS: TLabel
                Left = 278
                Top = 17
                Width = 24
                Height = 15
                Caption = '0,00'
                Font.Charset = ANSI_CHARSET
                Font.Color = clMaroon
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblDesSal_OS: TLabel
                Left = 178
                Top = 18
                Width = 94
                Height = 14
                Caption = 'Saldo Disp. p/ OS:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object imgSaldos: TImage
                Left = 657
                Top = 0
                Width = 16
                Height = 16
                AutoSize = True
                Center = True
                Picture.Data = {
                  0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                  0000001008060000001FF3FF610000001974455874536F667477617265004164
                  6F626520496D616765526561647971C9653C0000000E744558745469746C6500
                  4C697374426F783B0357E96A0000018E49444154785E7D52BD4A0341109E4DA2
                  58F82242109B44B03168A38858042120162156561AD427B0129F40D1222068A1
                  8520D828DA5AA8A04F72C118DDDB19776677E3925C32DCCECF31F3CDB7335B20
                  22504AE54EAFDE1E544E558085F8634B6CE50445A00075FABCBD595A24225300
                  272AF9D29566BD14EAC13B99727CF632CF35EC07003086B821202BF9A8D799E8
                  DF1F1FCBDB5C847E00658C8120E737EF805C6815A2834A920EEC36E604CCE020
                  001894DB4A516DA518B1573D468C4A79080CA08F0102F9C4CBBBCF4C063BF559
                  C93169160383D215D1C0FA52314C9CAD67C160E8AF3082015A7B71FB110D9484
                  4DD2FE8666BD0C04A318100983DAEAB4BB772000CA6D85527B86CC0019C00FB3
                  65B7E09A93585649BB037B8DB26F92C98037E066B0B13613BA7BE502A25F4092
                  DC0100952202FA35B6AE5FC3E3E1586CDB32D8DF2A010E1922A01BA248A33A05
                  CA0D5E6C2C8490FD901049D0C726265D224545F12AF9643040FDD37D3C38BC5F
                  90C218A16F131C68DD7DB24E1A03E893A3EAB28F150C4AFC8F7CB1E6E00F942D
                  47B1285CD8E90000000049454E44AE426082}
                Transparent = True
                Visible = False
              end
              object pnlInfoItens: TPanel
                Left = 822
                Top = 0
                Width = 528
                Height = 32
                Align = alRight
                BevelOuter = bvNone
                Color = clWhite
                Enabled = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentBackground = False
                ParentFont = False
                TabOrder = 0
                StyleElements = [seFont, seBorder]
                object pnlMostraPrecoProd: TPanel
                  Left = 0
                  Top = 0
                  Width = 528
                  Height = 15
                  Align = alClient
                  BevelOuter = bvNone
                  Caption = 
                    'Pressione [Shift] + [F7] para visualizar '#250'ltimos pre'#231'os do produ' +
                    'to para o vendedor selecionado'
                  Color = clWhite
                  Enabled = False
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clSilver
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = [fsBold]
                  ParentBackground = False
                  ParentFont = False
                  TabOrder = 0
                  StyleElements = []
                end
                object pnlAg_Pec: TPanel
                  Left = 0
                  Top = 15
                  Width = 528
                  Height = 17
                  Align = alBottom
                  BevelOuter = bvNone
                  Caption = 'Pressione [F3] para definir itens que est'#227'o "Aguardando Pe'#231'as"'
                  Color = clWhite
                  Enabled = False
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clSilver
                  Font.Height = -11
                  Font.Name = 'Arial'
                  Font.Pitch = fpVariable
                  Font.Style = [fsBold]
                  ParentBackground = False
                  ParentFont = False
                  TabOrder = 1
                  StyleElements = []
                end
              end
            end
          end
          object pnlLegendas: TFlowPanel
            Left = 0
            Top = 151
            Width = 1352
            Height = 16
            Align = alBottom
            Alignment = taLeftJustify
            BevelOuter = bvNone
            Color = 16770261
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 4
            object pnlLegInativoCmp: TPanel
              AlignWithMargins = True
              Left = 1
              Top = 1
              Width = 108
              Height = 12
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alLeft
              Anchors = []
              BevelOuter = bvNone
              Color = 16770261
              Ctl3D = False
              ParentBackground = False
              ParentCtl3D = False
              TabOrder = 0
              Visible = False
              object shpInativoCmp: TShape
                Left = 3
                Top = 2
                Width = 10
                Height = 10
                Brush.Color = 36095
              end
              object lblLegInativoCmp: TLabel
                Left = 15
                Top = 1
                Width = 86
                Height = 12
                Caption = 'Inativo para Compra'
              end
            end
            object pnlLegItemEsp: TPanel
              AlignWithMargins = True
              Left = 111
              Top = 1
              Width = 92
              Height = 14
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alLeft
              Anchors = []
              BevelOuter = bvNone
              Color = 16770261
              Ctl3D = False
              ParentBackground = False
              ParentCtl3D = False
              TabOrder = 1
              Visible = False
              object shpItemEsp: TShape
                Left = 6
                Top = 2
                Width = 10
                Height = 10
                Brush.Color = clGreen
              end
              object lblLegItemEsp: TLabel
                Left = 18
                Top = 1
                Width = 57
                Height = 12
                Caption = 'Item Especial'
              end
            end
          end
        end
        object tbsServicos: TTabSheet
          Caption = '[CTRL+S] Servi'#231'os'
          ImageIndex = 1
          object pgcServicos: TPageControl
            Left = 0
            Top = 0
            Width = 1352
            Height = 167
            ActivePage = tbsServicosItens
            Align = alClient
            Style = tsFlatButtons
            TabOrder = 0
            object tbsServicosItens: TTabSheet
              Caption = 'Servi'#231'os'
              object dbgServico: TDBGridCitel
                Left = 0
                Top = 113
                Width = 1344
                Height = 5
                Align = alClient
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                ReadOnly = True
                TabOrder = 2
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clBlack
                TitleFont.Height = 14
                TitleFont.Name = 'Arial'
                TitleFont.Pitch = fpVariable
                TitleFont.Style = []
                OnDrawColumnCell = dbgServicoDrawColumnCell
                OnDblClick = dbgServicoDblClick
                OnKeyDown = dbgServicoKeyDown
                CorZebra = clMoneyGreen
                Zebra = False
                DestacarMouse = False
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'CODSER'
                    Title.Caption = 'C'#243'd. Servi'#231'o'
                    Width = 67
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'DESSER'
                    Title.Caption = 'Descri'#231#227'o'
                    Width = 590
                    Visible = True
                  end
                  item
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'TECSER'
                    Title.Alignment = taCenter
                    Title.Caption = 'C'#243'd.Tec.'
                    Width = 48
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'QTDSER'
                    Title.Caption = 'Qtde'
                    Width = 44
                    Visible = True
                  end
                  item
                    Alignment = taRightJustify
                    Expanded = False
                    FieldName = 'VALUNI'
                    Title.Alignment = taRightJustify
                    Title.Caption = 'Vlr. Unit.'
                    Width = 77
                    Visible = True
                  end
                  item
                    Alignment = taRightJustify
                    Expanded = False
                    FieldName = 'DESESP'
                    Title.Alignment = taRightJustify
                    Title.Caption = 'Desc. Esp.'
                    Width = 77
                    Visible = True
                  end
                  item
                    Alignment = taRightJustify
                    Expanded = False
                    FieldName = 'VALSER'
                    Title.Alignment = taRightJustify
                    Title.Caption = 'Valor'
                    Width = 77
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'BRINDE'
                    Title.Caption = 'Brinde?'
                    Width = 41
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'TIPBRI'
                    Title.Caption = 'Tipo Brinde'
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'CODDES'
                    Title.Caption = 'Tecnico Servi'#231'o'
                    Visible = False
                  end
                  item
                    Expanded = False
                    FieldName = 'COBAPA'
                    Title.Caption = #192' Parte'
                    Visible = False
                  end>
              end
              object pnlServicos: TPanel
                Left = 0
                Top = 30
                Width = 1344
                Height = 83
                Align = alTop
                Enabled = False
                ParentColor = True
                TabOrder = 1
                DesignSize = (
                  1344
                  83)
                object Label17: TLabel
                  Left = 31
                  Top = 11
                  Width = 40
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'Servi'#231'o:'
                end
                object lblValSer: TLabel
                  Left = 151
                  Top = 57
                  Width = 28
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'Valor:'
                end
                object Label20: TLabel
                  Left = 30
                  Top = 34
                  Width = 41
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'T'#233'cnico:'
                end
                object lblQtdSer: TLabel
                  Left = 13
                  Top = 57
                  Width = 58
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'Quantidade:'
                end
                object edtCodSe1: TEditFocus
                  Tag = 99
                  Left = 73
                  Top = 7
                  Width = 65
                  Height = 22
                  Alignment = taLeftJustify
                  MaxLength = 5
                  TabOrder = 0
                  OnKeyPress = edtCodSe1KeyPress
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = True
                  TamCampo = 5
                  TipoTexto = ttNumerico
                end
                object edtDesSe1: TEditFocus
                  Tag = 99
                  Left = 139
                  Top = 7
                  Width = 1197
                  Height = 22
                  Alignment = taLeftJustify
                  Anchors = [akLeft, akTop, akRight]
                  CharCase = ecUpperCase
                  MaxLength = 95
                  ReadOnly = True
                  TabOrder = 1
                  OnChange = edtDesSe1Change
                  OnKeyPress = edtDesSe1KeyPress
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = False
                  TamCampo = 0
                  TipoTexto = ttAlfanumerico
                end
                object edtValSe1: TEditFocus
                  Tag = 99
                  Left = 181
                  Top = 53
                  Width = 65
                  Height = 22
                  Alignment = taRightJustify
                  MaxLength = 12
                  TabOrder = 5
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
                object btnCancelaSe1: TBitBtnLocked
                  Left = 1242
                  Top = 55
                  Width = 95
                  Height = 22
                  Anchors = [akTop, akRight]
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
                  TabOrder = 10
                  OnClick = btnCancelaSe1Click
                end
                object btnAdicionarSe1: TBitBtnLocked
                  Left = 1146
                  Top = 55
                  Width = 95
                  Height = 22
                  Anchors = [akTop, akRight]
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
                  TabOrder = 9
                  OnClick = btnAdicionarSe1Click
                end
                object edtCodTecSe1: TEditFocus
                  Tag = 99
                  Left = 73
                  Top = 30
                  Width = 65
                  Height = 22
                  Alignment = taLeftJustify
                  CharCase = ecUpperCase
                  MaxLength = 3
                  TabOrder = 2
                  OnExit = edtCodTecSe1Exit
                  OnKeyPress = edtCodTecSe1KeyPress
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = True
                  TamCampo = 3
                  TipoTexto = ttAlfanumerico
                end
                object edtDesTecSe1: TEditFocus
                  Left = 139
                  Top = 30
                  Width = 1197
                  Height = 22
                  TabStop = False
                  Alignment = taLeftJustify
                  Anchors = [akLeft, akTop, akRight]
                  CharCase = ecUpperCase
                  Color = 16768952
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
                object chkBrindeSer: TCheckBox
                  Left = 263
                  Top = 57
                  Width = 66
                  Height = 17
                  Caption = 'Brinde?'
                  TabOrder = 6
                  OnClick = chkBrindeSerClick
                end
                object pnlTipBriSer: TPanel
                  Left = 326
                  Top = 52
                  Width = 226
                  Height = 25
                  BevelOuter = bvNone
                  ParentBackground = False
                  ParentColor = True
                  TabOrder = 7
                  Visible = False
                  object lblTipBriSer: TLabel
                    Left = 13
                    Top = 5
                    Width = 72
                    Height = 14
                    Alignment = taRightJustify
                    Caption = 'Tipo de Brinde:'
                  end
                  object clbTipBriSer: TColorLabel
                    Left = 117
                    Top = 5
                    Width = 100
                    Height = 14
                    Caption = '(G)arantia (C)ortesia'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clBlack
                    Font.Height = 14
                    Font.Name = 'Arial'
                    Font.Pitch = fpVariable
                    Font.Style = []
                    ParentFont = False
                    CorDestaque = clRed
                  end
                  object edtTipBriSer: TEditFocus
                    Tag = 99
                    Left = 88
                    Top = 1
                    Width = 27
                    Height = 22
                    Alignment = taCenter
                    CharCase = ecUpperCase
                    ImeName = 'Portugu'#234's (Brasil ABNT)'
                    MaxLength = 1
                    TabOrder = 0
                    Text = 'G'
                    NormalColor = clWindow
                    FocusColor = clInfoBk
                    RequeridoColor = clRed
                    Requerido = False
                    CompZeros = False
                    TamCampo = 1
                    TipoTexto = ttAlfabetico
                  end
                end
                object chkCobAPaSer: TCheckBox
                  Left = 558
                  Top = 57
                  Width = 97
                  Height = 17
                  Caption = 'Cobrar '#224' Parte'
                  TabOrder = 8
                  Visible = False
                end
                object edtQtdSe1: TEditFocus
                  Tag = 99
                  Left = 73
                  Top = 53
                  Width = 65
                  Height = 22
                  Alignment = taRightJustify
                  MaxLength = 12
                  TabOrder = 4
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
              object pnlMostraPrecoServ: TPanel
                Left = 0
                Top = 118
                Width = 1344
                Height = 17
                Align = alBottom
                BevelOuter = bvNone
                Caption = 
                  'Pressione [Shift] + [F7] para visualizar '#250'ltimos pre'#231'os do servi' +
                  #231'o para o vendedor selecionado'
                Color = clWhite
                Enabled = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clSilver
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentBackground = False
                ParentFont = False
                TabOrder = 3
                StyleElements = []
              end
              object pnlEmpSer: TPanel
                Left = 0
                Top = 0
                Width = 1344
                Height = 30
                Align = alTop
                TabOrder = 0
                object Label1: TLabel
                  Left = 48
                  Top = 8
                  Width = 23
                  Height = 14
                  Alignment = taRightJustify
                  Caption = 'Emp:'
                end
                object lblInfoEmpSer: TLabel
                  Left = 464
                  Top = 8
                  Width = 304
                  Height = 14
                  Caption = 'A Empresa informada ser'#225' respons'#225'vel por todos os Servi'#231'os.'
                end
                object edtEmpSer: TEditFocus
                  Tag = 99
                  Left = 73
                  Top = 4
                  Width = 31
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
                  TabOrder = 0
                  OnKeyPress = edtEmpSerKeyPress
                  NormalColor = clWindow
                  FocusColor = clInfoBk
                  RequeridoColor = clRed
                  Requerido = False
                  CompZeros = True
                  TamCampo = 3
                  TipoTexto = ttInteiro
                end
                object edtDesEmpser: TEditFocus
                  Left = 105
                  Top = 4
                  Width = 336
                  Height = 22
                  TabStop = False
                  Alignment = taLeftJustify
                  CharCase = ecUpperCase
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
            end
            object tbsServicosDiscriminacao: TTabSheet
              Caption = 'D&iscrimina'#231#227'o dos Servi'#231'os'
              ImageIndex = 1
              object edtDisSer: TMemoFocus
                Tag = 99
                Left = 0
                Top = 0
                Width = 1344
                Height = 135
                Align = alClient
                Enabled = False
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ScrollBars = ssVertical
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                StringQuebra = '<<csq>>'
              end
            end
          end
        end
        object tbsDocsRelacionados: TTabSheet
          Caption = '[CTRL+F] Docs. Fiscais Relacionados'
          ImageIndex = 3
          object grbDocEntrada: TGroupBox
            Left = 0
            Top = 0
            Width = 1352
            Height = 107
            Align = alTop
            Caption = '   Documento de Entrada   '
            Enabled = False
            TabOrder = 0
            StyleElements = [seFont, seBorder]
            object lblNumDocEntr: TLabel
              Left = 28
              Top = 16
              Width = 40
              Height = 14
              Caption = 'N'#250'mero:'
            end
            object lblEspDocEnt: TLabel
              Left = 218
              Top = 16
              Width = 41
              Height = 14
              Caption = 'Esp'#233'cie:'
            end
            object lblEmpDocEnt: TLabel
              Left = 289
              Top = 16
              Width = 45
              Height = 14
              Caption = 'Empresa:'
            end
            object Label25: TLabel
              Left = 367
              Top = 16
              Width = 62
              Height = 14
              Caption = 'Dta. Entrada:'
            end
            object Label31: TLabel
              Left = 8
              Top = 38
              Width = 60
              Height = 14
              Caption = 'Chave NF-e:'
            end
            object lblEquip: TLabel
              Left = 10
              Top = 60
              Width = 58
              Height = 14
              Caption = 'Equip. NF-e:'
            end
            object Label24: TLabel
              Left = 156
              Top = 16
              Width = 28
              Height = 14
              Caption = 'S'#233'rie:'
            end
            object edtNumDocEnt: TEditFocus
              Left = 71
              Top = 13
              Width = 80
              Height = 22
              Alignment = taLeftJustify
              ReadOnly = True
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEspDocEnt: TEditFocus
              Left = 260
              Top = 13
              Width = 20
              Height = 22
              Alignment = taLeftJustify
              ReadOnly = True
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmpDocEnt: TEditFocus
              Left = 335
              Top = 13
              Width = 25
              Height = 22
              Alignment = taLeftJustify
              ReadOnly = True
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtChaveNfeEnt: TEditFocus
              Left = 71
              Top = 35
              Width = 424
              Height = 22
              Alignment = taLeftJustify
              Enabled = False
              ReadOnly = True
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object mskDtaDocEnt: TMaskEditFocus
              Tag = 99
              Left = 431
              Top = 13
              Width = 64
              Height = 22
              CharCase = ecUpperCase
              EditMask = '99/99/9999'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              ReadOnly = True
              TabOrder = 4
              Text = '  /  /    '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = True
            end
            object Panel1: TPanel
              Left = 2
              Top = 81
              Width = 1348
              Height = 24
              Align = alBottom
              BevelOuter = bvNone
              Color = clGray
              ParentBackground = False
              TabOrder = 7
              StyleElements = []
              object blnRealizarEntrada: TBitBtnLocked
                Left = 4
                Top = 1
                Width = 120
                Height = 22
                Caption = 'Realizar Entrada'
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000030000
                  000C000000120000001400000014000000140000001400000014000000150000
                  0015000000140000000D000000030000000000000000000000000000000B7A5B
                  50C3AB7F6FFFAA7E6FFFAB7D6FFFAA7D6EFFAA7D6EFFA97C6DFFA97C6DFFAA7C
                  6DFFA87B6CFF79584DC50000000D00000000000000000000000000000010AD82
                  72FFFBF7F4FFFAF6F4FFFBF6F4FFFBF6F3FFFBF5F3FFFAF5F2FFFAF5F2FFFAF4
                  F1FFFAF4F1FFAA7C6EFF0000001300000000000000000000000000000011AF84
                  75FFFCF8F7FFF6EEE8FFF7EDE8FFF6EDE8FFF6EDE7FFF6EDE7FFF6ECE7FFF6EC
                  E7FFFBF5F3FFAB7E6FFF0000001300000000000000000000000000000010B187
                  78FFFDFAF8FFF8EFEAFFC39C8CFFC29B8AFFC29B89FFC29A89FFC19989FFC199
                  88FFECE2DEFFDDD3D0FF000000260000000E00000003000000000000000FB389
                  7BFFFDFBFAFFF8F1EDFFF8F0EDFFF8F0ECFFF7F0ECFFF7F0ECFFF7EFEBFFF7EF
                  EBFFF2F1F1FF528771FF267255FF1A503BC50000000D000000000000000EB68D
                  7EFFFEFCFCFFF9F2EFFFC6A191FFC5A090FFC5A090FFC59F8FFFEEE5E0FFE7DE
                  D9FFD6CDC9FF2A7C5EFF27D596FF287758FF0000001F0000000C0000000DB890
                  81FFFEFDFDFFFAF5F2FFF9F4F1FFF9F4F1FFF9F3F1FFF9F3F0FFF5F4F3FF60A0
                  89FF2E8767FF2D8364FF33DBA0FF2B7D5FFF297B5DFF1D5641C20000000DBA93
                  85FFFEFEFEFFFAF6F4FF00A361FF00A060FF009C5BFF009758FFB8DBCCFF3291
                  70FF98F1D6FF41E2ADFF40E3AAFF3DE1AAFF3CE0A9FF2B7F61FF0000000CBC97
                  88FFFFFEFEFFFBF8F6FFFBF7F6FFFAF7F6FFFBF7F5FFFAF7F4FFF9F8F7FF64AD
                  94FF349674FF329372FF4AE8B6FF308D6CFF2F8A6AFF22634CC40000000BC099
                  8BFFFFFFFFFFFCF8F8FFCDAD9DFFCCAC9DFFCCAB9CFFCBAB9BFFF1E9E5FFEEE5
                  E1FFE9E0DCFF369A78FFB9F8E7FF339473FF0000000D000000050000000AC19D
                  8EFFFFFFFFFFFCFAF9FFFCFAF9FFFCFAF8FFFCF9F8FFFBFAF8FFFCF9F8FFFBF9
                  F8FFFCFCFCFF65B095FF379E7CFF28735AC0000000040000000000000009C4A0
                  91FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFEEE4E1FF0000000D000000020000000100000000000000069379
                  6EC3C5A294FFC5A294FFC4A193FFC4A092FFC3A092FFC39F91FFC29F90FFC29E
                  90FFC29D8FFF8F7469C400000007000000000000000000000000000000010000
                  00050000000800000009000000090000000900000009000000090000000A0000
                  000A000000090000000700000002000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000}
                TabOrder = 0
                OnClick = blnRealizarEntradaClick
              end
              object btnVincularEntrada: TBitBtnLocked
                Left = 130
                Top = 1
                Width = 120
                Height = 22
                Caption = 'Vincular Entrada'
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000030000000C00000010000000110000
                  0011000000120000001200000013000000130000001000000004000000000000
                  00000000000000000000000000000000000BA97563FFA87462FFA77261FFA571
                  5FFFA5705EFFA36F5DFFA36D5CFFA26D5BFFA26C5AFF0000000F000000000000
                  00000000000000000000000000000000000DAB7866FFFDFBF8FFF7EFE8FFF6EF
                  E6FFF6EEE6FFF5EEE5FFF5EDE4FFF5EDE4FFA36D5CFF00000013000000000000
                  0000265080B7336CB1FF326BB0FF2E63A6FFAD7C6AFFFDFCFAFFF7F0E9FFF7F0
                  E8FFF7EFE7FFF6EFE7FFF6EEE6FFF5EEE5FFA46F5DFF00000012000000000000
                  00003976B8FF91D2F4FF66BEEEFF60B5E4FFB07F6DFFFEFDFCFFF7F2EAFFF8F1
                  E9FFF7F0E9FFF6F0E8FFF6EFE7FFF6EFE6FFA67260FF00000011000000000000
                  00003F7DBCFF9AD6F5FF6CC3F0FF66B8E5FFB28070FFFEFEFDFFF8F3ECFFF8F2
                  EBFFF7F1EAFFF7F1E9FFF7F0E8FFF7EFE8FFA87563FF00000010000000000000
                  00004384C1FFA4DBF6FF73C7F1FF6CBEE8FFB48473FFFFFFFEFFF9F3EEFFF9F3
                  EDFFF9F2ECFFF8F2EBFFF7F1EAFFF7F0E9FFAB7766FF0000000F000000000000
                  0000488BC5FFADE1F8FF7ACCF2FF73C3E9FFB68676FFFFFFFFFFF9F5EEFFF9F4
                  EEFFF9F3EDFFF8F3ECFFF8F2EBFFF7F2EBFFAC7A6AFF0000000E000000000000
                  00004C92CAFFB6E6FAFF81D2F4FF7AC9EBFFB88878FFFFFFFFFFFAF5F0FFF9F5
                  EFFFF9F5EFFFF9F4EEFFF9F3EDFFF9F3ECFFAF7E6CFF0000000D000000000000
                  00005098CDFFBEE9FAFF88D6F6FF81CEEEFFBB8B7BFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFCFAFFB1816FFF0000000C000000000000
                  0000539DD1FFC5EDFBFF8FDBF7FF89D5F2FFBD8D7DFFBB8C7CFFBA8B7BFFB989
                  79FFB98977FFB78876FFB68674FFB58373FFB38371FF00000009000000000000
                  000056A1D4FFCBF0FCFF95E0F8FF82CBE9FF72B7D9FF71B7D9FF70B7DAFF70B8
                  DBFF6FB7DBFF4385BBFF00000009000000090000000800000002000000000000
                  000058A5D7FFCBEDF8FF73B2D0FF5792B7FF5893B7FF5995BAFF5B99BDFF62A3
                  C9FF69AFD4FF4184BBFF00000000000000000000000000000000000000000000
                  000059A8D9FFBCDBE7FF8E7875FF9B7061FF946A5BFF8F6456FF885D50FF7B65
                  63FF97BCD3FF488EC4FF00000000000000000000000000000000000000000000
                  0000437EA2BD4A90BFFFB48E7FFFF3EDE7FFDEC9B8FFDDC8B5FFDBC4B2FF9770
                  60FF3B7BAEFF40799EBD00000000000000000000000000000000000000000000
                  00000000000000000000876B60BDB69181FFB69080FFB58E7FFFB28C7DFF7D60
                  54BD000000000000000000000000000000000000000000000000}
                TabOrder = 1
                OnClick = btnVincularEntradaClick
              end
              object btnRemoverEntrada: TBitBtnLocked
                Left = 256
                Top = 1
                Width = 120
                Height = 22
                Caption = 'Remover Entrada'
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000030000
                  000B000000120000001300000013000000140000001400000014000000140000
                  0014000000140000001500000015000000140000000D000000030000000B1C11
                  6CC3261796FF271696FF261695FF261594FF251594FF251594FF241394FF2412
                  93FF241292FF231292FF231192FF231191FF190C68C50000000C0000000F2B1C
                  9BFF384AD3FF2637CEFF3042D2FF4254D9FF3646D4FF2437CCFF2434CCFF3444
                  D3FF3C4ED6FF2A3ACEFF202FC9FF1E2CC9FF251595FF000000120000000F3121
                  A0FF4356D7FF374BD5FF3F4BCBFF2827ABFF363CBEFF3E4FD6FF3D4ED5FF353A
                  BEFF2827ABFF3B45C9FF2F41D0FF2332CCFF291A99FF000000120000000E3529
                  A5FF4E62DBFF444FCCFF605DBDFFEDEDF8FF8B89CEFF383CBCFF383CBBFF8B89
                  CEFFEDEDF8FF5F5DBDFF3D47C9FF293ACEFF2D1F9EFF000000110000000D392F
                  ABFF596FDFFF2722A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
                  EDFFF3E9E2FFECE6EBFF2721A5FF2F42D1FF3326A3FF0000000F0000000C4036
                  B1FF657AE2FF3135B7FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
                  E2FFEADAD1FF7F6FACFF2E31B6FF3549D5FF372CA9FF0000000E0000000B453D
                  B6FF6E83E5FF485EDCFF393BB7FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
                  E5FF897DB8FF3739B6FF4054D9FF3D51D7FF3C33AFFF0000000D0000000A4A44
                  BCFF788FE8FF6077E3FF4B4BBBFF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
                  E8FF9087C5FF4949BAFF596FDFFF4359DAFF423AB4FF0000000C00000009504C
                  C2FF92A7EEFF5655BCFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
                  EAFFFAF5F2FF8F89CAFF5453BCFF6278E2FF4943B9FF0000000B000000086B6A
                  D0FFADC1F4FF2A1E9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
                  D8FFF4ECE7FFE5D9DCFF2A1D9BFF8B9EEBFF6563C9FF0000000A000000077577
                  D6FFB1C6F5FF6E77D1FF5747A1FFCCB6BCFF7A68A8FF4E4CB7FF4F4EB8FF7A68
                  A8FFCBB5BCFF5746A1FF6B75D0FF8EA1ECFF706ED0FF0000000900000006797B
                  DAFFB5CAF6FF93A7EEFF7079D2FF2E229BFF5453BBFF93A7EEFF93A7EEFF5555
                  BCFF2E219BFF6F77D1FF91A4EDFF90A3EDFF7475D4FF00000008000000057D80
                  DEFFB9CDF6FFB9CDF6FFB9CCF6FFB9CCF6FFB9CDF6FFB8CCF6FFB8CCF6FFB7CC
                  F6FFB7CBF6FFB6CBF6FFB5C9F6FFB5C9F6FF787AD8FF00000006000000036062
                  A6C08184E1FF8183E0FF8083E0FF7F83DFFF7F83DFFF7F82DFFF7E81DFFF7E81
                  DEFF7D81DEFF7D80DEFF7D7FDEFF7C7FDDFF5C5EA3C100000004000000000000
                  0002000000030000000400000004000000040000000400000004000000040000
                  0004000000040000000400000005000000050000000300000001}
                TabOrder = 2
                OnClick = btnRemoverEntradaClick
              end
            end
            object edtSerDocEnt: TEditFocus
              Left = 185
              Top = 13
              Width = 25
              Height = 22
              Alignment = taLeftJustify
              ReadOnly = True
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object cmbEquEnt: TComboBoxFocus
              Tag = 99
              Left = 71
              Top = 57
              Width = 424
              Height = 22
              TabOrder = 6
              OnChange = cmbEquEntChange
              OnExit = cmbEquEntExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
          object grbDocSaida: TGroupBox
            Left = 0
            Top = 107
            Width = 1352
            Height = 63
            Align = alTop
            Caption = '   Documento de Sa'#237'da   '
            Enabled = False
            TabOrder = 1
            StyleElements = [seFont, seBorder]
            object lnlNumDocSai: TLabel
              Left = 28
              Top = 16
              Width = 40
              Height = 14
              Caption = 'N'#250'mero:'
            end
            object lblEspDocSai: TLabel
              Left = 218
              Top = 16
              Width = 41
              Height = 14
              Caption = 'Esp'#233'cie:'
            end
            object lblEmpDocSai: TLabel
              Left = 289
              Top = 16
              Width = 45
              Height = 14
              Caption = 'Empresa:'
            end
            object lblDtaDocSai: TLabel
              Left = 377
              Top = 16
              Width = 52
              Height = 14
              Caption = 'Dta. Sa'#237'da:'
            end
            object lblSerDocSai: TLabel
              Left = 156
              Top = 16
              Width = 28
              Height = 14
              Caption = 'S'#233'rie:'
            end
            object edtNumDocSai: TEditFocus
              Left = 71
              Top = 13
              Width = 80
              Height = 22
              Alignment = taLeftJustify
              ReadOnly = True
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEspDocSai: TEditFocus
              Left = 260
              Top = 13
              Width = 20
              Height = 22
              Alignment = taLeftJustify
              ReadOnly = True
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmpDocSai: TEditFocus
              Left = 335
              Top = 13
              Width = 25
              Height = 22
              Alignment = taLeftJustify
              ReadOnly = True
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object mskDtaDocSai: TMaskEditFocus
              Tag = 99
              Left = 431
              Top = 13
              Width = 64
              Height = 22
              CharCase = ecUpperCase
              EditMask = '99/99/9999'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 10
              ReadOnly = True
              TabOrder = 4
              Text = '  /  /    '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = True
            end
            object Panel2: TPanel
              Left = 2
              Top = 37
              Width = 1348
              Height = 24
              Align = alBottom
              BevelOuter = bvNone
              Color = clGray
              ParentBackground = False
              TabOrder = 5
              StyleElements = []
              object btnRealizarSaida: TBitBtnLocked
                Left = 4
                Top = 2
                Width = 120
                Height = 22
                Caption = 'Realizar Sa'#237'da'
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000030000
                  000C000000120000001400000014000000140000001400000014000000150000
                  0015000000140000000D000000030000000000000000000000000000000B7A5B
                  50C3AB7F6FFFAA7E6FFFAB7D6FFFAA7D6EFFAA7D6EFFA97C6DFFA97C6DFFAA7C
                  6DFFA87B6CFF79584DC50000000D00000000000000000000000000000010AD82
                  72FFFBF7F4FFFAF6F4FFFBF6F4FFFBF6F3FFFBF5F3FFFAF5F2FFFAF5F2FFFAF4
                  F1FFFAF4F1FFAA7C6EFF0000001300000000000000000000000000000011AF84
                  75FFFCF8F7FFF6EEE8FFF7EDE8FFF6EDE8FFF6EDE7FFF6EDE7FFF6ECE7FFF6EC
                  E7FFFBF5F3FFAB7E6FFF0000001300000000000000000000000000000010B187
                  78FFFDFAF8FFF8EFEAFFC39C8CFFC29B8AFFC29B89FFC29A89FFC19989FFC199
                  88FFECE2DEFFDDD3D0FF000000260000000E00000003000000000000000FB389
                  7BFFFDFBFAFFF8F1EDFFF8F0EDFFF8F0ECFFF7F0ECFFF7F0ECFFF7EFEBFFF7EF
                  EBFFF2F1F1FF528771FF267255FF1A503BC50000000D000000000000000EB68D
                  7EFFFEFCFCFFF9F2EFFFC6A191FFC5A090FFC5A090FFC59F8FFFEEE5E0FFE7DE
                  D9FFD6CDC9FF2A7C5EFF27D596FF287758FF0000001F0000000C0000000DB890
                  81FFFEFDFDFFFAF5F2FFF9F4F1FFF9F4F1FFF9F3F1FFF9F3F0FFF5F4F3FF60A0
                  89FF2E8767FF2D8364FF33DBA0FF2B7D5FFF297B5DFF1D5641C20000000DBA93
                  85FFFEFEFEFFFAF6F4FF00A361FF00A060FF009C5BFF009758FFB8DBCCFF3291
                  70FF98F1D6FF41E2ADFF40E3AAFF3DE1AAFF3CE0A9FF2B7F61FF0000000CBC97
                  88FFFFFEFEFFFBF8F6FFFBF7F6FFFAF7F6FFFBF7F5FFFAF7F4FFF9F8F7FF64AD
                  94FF349674FF329372FF4AE8B6FF308D6CFF2F8A6AFF22634CC40000000BC099
                  8BFFFFFFFFFFFCF8F8FFCDAD9DFFCCAC9DFFCCAB9CFFCBAB9BFFF1E9E5FFEEE5
                  E1FFE9E0DCFF369A78FFB9F8E7FF339473FF0000000D000000050000000AC19D
                  8EFFFFFFFFFFFCFAF9FFFCFAF9FFFCFAF8FFFCF9F8FFFBFAF8FFFCF9F8FFFBF9
                  F8FFFCFCFCFF65B095FF379E7CFF28735AC0000000040000000000000009C4A0
                  91FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFEEE4E1FF0000000D000000020000000100000000000000069379
                  6EC3C5A294FFC5A294FFC4A193FFC4A092FFC3A092FFC39F91FFC29F90FFC29E
                  90FFC29D8FFF8F7469C400000007000000000000000000000000000000010000
                  00050000000800000009000000090000000900000009000000090000000A0000
                  000A000000090000000700000002000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000}
                TabOrder = 0
                OnClick = btnRealizarSaidaClick
              end
              object btnVincularSaida: TBitBtnLocked
                Left = 130
                Top = 2
                Width = 120
                Height = 22
                Caption = 'Vincular Sa'#237'da'
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000030000000C00000010000000110000
                  0011000000120000001200000013000000130000001000000004000000000000
                  00000000000000000000000000000000000BA97563FFA87462FFA77261FFA571
                  5FFFA5705EFFA36F5DFFA36D5CFFA26D5BFFA26C5AFF0000000F000000000000
                  00000000000000000000000000000000000DAB7866FFFDFBF8FFF7EFE8FFF6EF
                  E6FFF6EEE6FFF5EEE5FFF5EDE4FFF5EDE4FFA36D5CFF00000013000000000000
                  0000265080B7336CB1FF326BB0FF2E63A6FFAD7C6AFFFDFCFAFFF7F0E9FFF7F0
                  E8FFF7EFE7FFF6EFE7FFF6EEE6FFF5EEE5FFA46F5DFF00000012000000000000
                  00003976B8FF91D2F4FF66BEEEFF60B5E4FFB07F6DFFFEFDFCFFF7F2EAFFF8F1
                  E9FFF7F0E9FFF6F0E8FFF6EFE7FFF6EFE6FFA67260FF00000011000000000000
                  00003F7DBCFF9AD6F5FF6CC3F0FF66B8E5FFB28070FFFEFEFDFFF8F3ECFFF8F2
                  EBFFF7F1EAFFF7F1E9FFF7F0E8FFF7EFE8FFA87563FF00000010000000000000
                  00004384C1FFA4DBF6FF73C7F1FF6CBEE8FFB48473FFFFFFFEFFF9F3EEFFF9F3
                  EDFFF9F2ECFFF8F2EBFFF7F1EAFFF7F0E9FFAB7766FF0000000F000000000000
                  0000488BC5FFADE1F8FF7ACCF2FF73C3E9FFB68676FFFFFFFFFFF9F5EEFFF9F4
                  EEFFF9F3EDFFF8F3ECFFF8F2EBFFF7F2EBFFAC7A6AFF0000000E000000000000
                  00004C92CAFFB6E6FAFF81D2F4FF7AC9EBFFB88878FFFFFFFFFFFAF5F0FFF9F5
                  EFFFF9F5EFFFF9F4EEFFF9F3EDFFF9F3ECFFAF7E6CFF0000000D000000000000
                  00005098CDFFBEE9FAFF88D6F6FF81CEEEFFBB8B7BFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFCFAFFB1816FFF0000000C000000000000
                  0000539DD1FFC5EDFBFF8FDBF7FF89D5F2FFBD8D7DFFBB8C7CFFBA8B7BFFB989
                  79FFB98977FFB78876FFB68674FFB58373FFB38371FF00000009000000000000
                  000056A1D4FFCBF0FCFF95E0F8FF82CBE9FF72B7D9FF71B7D9FF70B7DAFF70B8
                  DBFF6FB7DBFF4385BBFF00000009000000090000000800000002000000000000
                  000058A5D7FFCBEDF8FF73B2D0FF5792B7FF5893B7FF5995BAFF5B99BDFF62A3
                  C9FF69AFD4FF4184BBFF00000000000000000000000000000000000000000000
                  000059A8D9FFBCDBE7FF8E7875FF9B7061FF946A5BFF8F6456FF885D50FF7B65
                  63FF97BCD3FF488EC4FF00000000000000000000000000000000000000000000
                  0000437EA2BD4A90BFFFB48E7FFFF3EDE7FFDEC9B8FFDDC8B5FFDBC4B2FF9770
                  60FF3B7BAEFF40799EBD00000000000000000000000000000000000000000000
                  00000000000000000000876B60BDB69181FFB69080FFB58E7FFFB28C7DFF7D60
                  54BD000000000000000000000000000000000000000000000000}
                TabOrder = 1
                OnClick = btnVincularSaidaClick
              end
              object btnRemoverSaida: TBitBtnLocked
                Left = 256
                Top = 2
                Width = 120
                Height = 22
                Caption = 'Remover Sa'#237'da'
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000030000
                  000B000000120000001300000013000000140000001400000014000000140000
                  0014000000140000001500000015000000140000000D000000030000000B1C11
                  6CC3261796FF271696FF261695FF261594FF251594FF251594FF241394FF2412
                  93FF241292FF231292FF231192FF231191FF190C68C50000000C0000000F2B1C
                  9BFF384AD3FF2637CEFF3042D2FF4254D9FF3646D4FF2437CCFF2434CCFF3444
                  D3FF3C4ED6FF2A3ACEFF202FC9FF1E2CC9FF251595FF000000120000000F3121
                  A0FF4356D7FF374BD5FF3F4BCBFF2827ABFF363CBEFF3E4FD6FF3D4ED5FF353A
                  BEFF2827ABFF3B45C9FF2F41D0FF2332CCFF291A99FF000000120000000E3529
                  A5FF4E62DBFF444FCCFF605DBDFFEDEDF8FF8B89CEFF383CBCFF383CBBFF8B89
                  CEFFEDEDF8FF5F5DBDFF3D47C9FF293ACEFF2D1F9EFF000000110000000D392F
                  ABFF596FDFFF2722A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
                  EDFFF3E9E2FFECE6EBFF2721A5FF2F42D1FF3326A3FF0000000F0000000C4036
                  B1FF657AE2FF3135B7FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
                  E2FFEADAD1FF7F6FACFF2E31B6FF3549D5FF372CA9FF0000000E0000000B453D
                  B6FF6E83E5FF485EDCFF393BB7FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
                  E5FF897DB8FF3739B6FF4054D9FF3D51D7FF3C33AFFF0000000D0000000A4A44
                  BCFF788FE8FF6077E3FF4B4BBBFF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
                  E8FF9087C5FF4949BAFF596FDFFF4359DAFF423AB4FF0000000C00000009504C
                  C2FF92A7EEFF5655BCFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
                  EAFFFAF5F2FF8F89CAFF5453BCFF6278E2FF4943B9FF0000000B000000086B6A
                  D0FFADC1F4FF2A1E9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
                  D8FFF4ECE7FFE5D9DCFF2A1D9BFF8B9EEBFF6563C9FF0000000A000000077577
                  D6FFB1C6F5FF6E77D1FF5747A1FFCCB6BCFF7A68A8FF4E4CB7FF4F4EB8FF7A68
                  A8FFCBB5BCFF5746A1FF6B75D0FF8EA1ECFF706ED0FF0000000900000006797B
                  DAFFB5CAF6FF93A7EEFF7079D2FF2E229BFF5453BBFF93A7EEFF93A7EEFF5555
                  BCFF2E219BFF6F77D1FF91A4EDFF90A3EDFF7475D4FF00000008000000057D80
                  DEFFB9CDF6FFB9CDF6FFB9CCF6FFB9CCF6FFB9CDF6FFB8CCF6FFB8CCF6FFB7CC
                  F6FFB7CBF6FFB6CBF6FFB5C9F6FFB5C9F6FF787AD8FF00000006000000036062
                  A6C08184E1FF8183E0FF8083E0FF7F83DFFF7F83DFFF7F82DFFF7E81DFFF7E81
                  DEFF7D81DEFF7D80DEFF7D7FDEFF7C7FDDFF5C5EA3C100000004000000000000
                  0002000000030000000400000004000000040000000400000004000000040000
                  0004000000040000000400000005000000050000000300000001}
                TabOrder = 2
                OnClick = btnRemoverSaidaClick
              end
            end
            object edtSerDocSai: TEditFocus
              Left = 185
              Top = 13
              Width = 25
              Height = 22
              Alignment = taLeftJustify
              ReadOnly = True
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
        end
        object tbsApontamentos: TTabSheet
          Caption = '[CTRL+H] Apontamento de Horas'
          ImageIndex = 5
          object dbgGridApo: TDBGridCitel
            Left = 0
            Top = 0
            Width = 1352
            Height = 167
            Align = alClient
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = 14
            TitleFont.Name = 'Arial'
            TitleFont.Pitch = fpVariable
            TitleFont.Style = []
            OnKeyDown = dbgGridAceKeyDown
            CorZebra = clMoneyGreen
            Zebra = False
            DestacarMouse = False
            Columns = <
              item
                Expanded = False
                FieldName = 'NOMTEC'
                Title.Caption = 'T'#233'cnico'
                Width = 236
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FASEAP'
                Title.Caption = 'Fase'
                Width = 385
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DTAINI'
                Title.Caption = 'Data / Hora Inicial'
                Width = 105
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DTAFIN'
                Title.Caption = 'Data / Hora Final'
                Width = 105
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TMPDUR'
                Title.Caption = 'Dura'#231#227'o'
                Width = 55
                Visible = True
              end>
          end
        end
        object tbsHistEquipamento: TTabSheet
          Caption = '[CTRL+E] Hist'#243'rico do Equipamento'
          ImageIndex = 6
          object trvHisEqu: TTreeView
            Left = 0
            Top = 0
            Width = 1352
            Height = 167
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Pitch = fpVariable
            Font.Style = []
            HotTrack = True
            Indent = 19
            ParentFont = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            OnCustomDrawItem = trvHisEquCustomDrawItem
          end
        end
      end
    end
    object pnlExiDados: TPanel
      Left = 0
      Top = 0
      Width = 1360
      Height = 16
      Align = alTop
      TabOrder = 4
      object lblExiDados: TLabel
        Left = 1
        Top = 1
        Width = 392
        Height = 14
        Cursor = crHandPoint
        Align = alClient
        Alignment = taCenter
        Caption = 
          'Ocultar "Dados Gerais da Ordem de Servi'#231'o" e "Dados do Equipamen' +
          'to"'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        OnClick = lblExiDadosClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 848
    Top = 560
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 904
    Top = 560
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 312
    Top = 8
  end
  object dtsIteEqu: TDataSource
    Left = 568
    Top = 560
  end
  object dtsServico: TDataSource
    Left = 624
    Top = 560
  end
  object dtsDefeito: TDataSource
    Left = 680
    Top = 560
  end
  object dtsAcessorios: TDataSource
    Left = 736
    Top = 560
  end
  object dtsApontamentos: TDataSource
    Left = 792
    Top = 560
  end
end
