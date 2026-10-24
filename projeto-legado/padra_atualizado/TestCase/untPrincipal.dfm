object Principal: TPrincipal
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  Caption = 'Citel Software - Gerador de Testes Unit'#225'rios'
  ClientHeight = 397
  ClientWidth = 658
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 658
    Height = 397
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = '&Principal'
      object PnlPrincipal: TPanel
        Left = 0
        Top = 0
        Width = 650
        Height = 369
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object gpbImpostos: TGroupBox
          Left = 0
          Top = 200
          Width = 650
          Height = 105
          Align = alTop
          Caption = ' Impostos/Regras '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object ChkIpi: TCheckBox
            Left = 16
            Top = 32
            Width = 97
            Height = 17
            Caption = 'IPI'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object chkICMS: TCheckBox
            Left = 16
            Top = 56
            Width = 97
            Height = 17
            Caption = 'ICMS\ST'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object chkIcmsEfetivo: TCheckBox
            Left = 16
            Top = 80
            Width = 97
            Height = 17
            Caption = 'ICMS Efetivo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object chkFcp: TCheckBox
            Left = 160
            Top = 32
            Width = 97
            Height = 17
            Caption = 'Difal\FCP'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object CheckBox1: TCheckBox
            Left = 160
            Top = 56
            Width = 97
            Height = 17
            Caption = 'CFOP'
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 4
          end
          object ChkPrecoCusto: TCheckBox
            Left = 160
            Top = 80
            Width = 97
            Height = 17
            Caption = 'Pre'#231'o Custo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object chkMargemVenda: TCheckBox
            Left = 281
            Top = 32
            Width = 97
            Height = 17
            Caption = 'Margem Venda'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
        end
        object gpbConexao: TGroupBox
          Left = 0
          Top = 0
          Width = 650
          Height = 103
          Align = alTop
          Caption = ' Conex'#227'o '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label1: TLabel
            Left = 11
            Top = 24
            Width = 45
            Height = 13
            Caption = 'Empresa:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 42
            Top = 47
            Width = 14
            Height = 13
            Caption = 'Ip:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 348
            Top = 48
            Width = 30
            Height = 13
            Caption = 'Porta:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 23
            Top = 73
            Width = 33
            Height = 13
            Caption = 'Banco:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object edtEmpresa: TEdit
            Left = 59
            Top = 21
            Width = 374
            Height = 19
            CharCase = ecUpperCase
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object edtIP: TEdit
            Left = 59
            Top = 45
            Width = 270
            Height = 19
            CharCase = ecUpperCase
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object edtPorta: TEdit
            Left = 381
            Top = 45
            Width = 52
            Height = 19
            CharCase = ecUpperCase
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object edtbanco: TEdit
            Left = 59
            Top = 69
            Width = 270
            Height = 19
            CharCase = ecUpperCase
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
        end
        object PnlProgresso: TPanel
          Left = 0
          Top = 305
          Width = 650
          Height = 20
          Align = alTop
          Color = clSilver
          ParentBackground = False
          TabOrder = 4
          object gProcesso: TGauge
            Left = 1
            Top = 1
            Width = 648
            Height = 18
            Align = alClient
            ForeColor = clSkyBlue
            Progress = 0
            ExplicitLeft = 0
          end
        end
        object pnlBotton: TPanel
          Left = 0
          Top = 328
          Width = 650
          Height = 41
          Align = alBottom
          TabOrder = 5
          object btnExecutar: TcxButton
            Left = 8
            Top = 8
            Width = 75
            Height = 25
            Caption = '&Executar'
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF009667
              5EFF9F6F60FF9F6F60FF9F6F60FF9F6F60FF9F6F60FF9F6F60FF9F6F60FF9F6F
              60FF9F6F60FF9F6F60FF9F6F60FF9F6F60FFFF00FF00FF00FF00FF00FF009969
              5FFFF6E0BFFFF4DDB8FFF3DAB4FFF3D7ADFFF2D5A7FFF0D3A3FFF0D09EFFEECC
              99FFEECA93FFEDC990FFEDC68CFF9F6F60FFFF00FF00FF00FF00FF00FF009D6C
              60FFF6E3C6FFF6E1C1FFF4DDBBFFF3DCB4FF008100FFF2D5AAFFF0D3A4FFF0CF
              9FFFEFCC99FFEFCB95FFEEC990FF9F6F60FFFF00FF00FF00FF00FF00FF00A16E
              60FFF7E6CEFFF6E5C7FFF4E1C1FF008100FF008100FF008100FFF3D5ABFFF0D3
              A5FFEFD19FFFEFCE9AFFEFCB96FF9F6F60FFFF00FF00FF00FF00FF00FF00A672
              62FFF8EAD4FFF7E7CEFF008100FF307A2AFF5F924BFF008100FF50883CFFF2D5
              ABFFF0D3A5FFF0D0A0FFEFCF9CFF9F6F60FFFF00FF00FF00FF00FF00FF00AB76
              63FFFAEEDAFFFAEBD5FF008100FFEFE2C2FFF6E2C2FFA7B883FF008100FF0081
              00FFEDD4A9FFF0D4A6FFF0D1A1FF9F6F60FFFF00FF00FF00FF00FF00FF00B078
              64FFFAF0E2FFFAEEDCFFF8EBD5FFF8E9D0FFF7E6CAFFF6E3C5FFE6D8B4FF0081
              00FF008100FFF2D7ADFFF2D4A7FF9F6F60FFFF00FF00FF00FF00FF00FF00B57D
              64FFFCF3E7FFFBF0E3FFFAEFDDFFFAEDD8FFF7E9D1FFF8E6CBFFF6E3C5FFF6E1
              C0FFF4DEBAFFF4DAB5FFF3D7ADFF9F6F60FFFF00FF00FF00FF00FF00FF00BB80
              65FFFCF7EDFFD58127FFD58127FFD58127FFD58127FFD58127FFD58127FFD581
              27FFD58127FFD58127FFF3DAB6FF9F6F60FFFF00FF00FF00FF00FF00FF00C083
              66FFFCF8F3FFFCF7EFFFFCF4EAFFFBF2E5FFFBEFDEFFF8EDD9FFF8EBD4FFF8E7
              CEFFF7E3C7FFF6E1C2FFF4DEBBFF9F6F60FFFF00FF00FF00FF00FF00FF00C487
              67FFFEFBF8FFFEFAF3FFFEF7EFFFFCF4EAFFFBF2E6FFFAEFE0FFF8EDDAFFF8EA
              D4FFF7E9CFFFF7E5C9FFF6E2C4FF9F6F60FFFF00FF00FF00FF00FF00FF00C989
              67FFFEFCFBFFD58127FFD58127FFD58127FFD58127FFD58127FFD58127FFD581
              27FFD58127FFD58127FFF7E5CAFF9F6F60FFFF00FF00FF00FF00FF00FF00CC8B
              68FFFFFFFFFFFFFEFCFFFEFCFAFFFEFBF4FFFEF8F0FFFCF6EDFFFCF4E7FFFAF2
              E2FFFAEFDCFFF8EDD7FFF8EAD1FF9F6F60FFFF00FF00FF00FF00FF00FF00CF8E
              68FFFFFFFFFFFFFFFFFFFFFFFCFFFFFCFAFFFEFBF6FFFEF8F0FFFCF7EEFFFBF4
              E9FFFBF2E3FFFBEFDDFFF8EDD8FF9F6F60FFFF00FF00FF00FF00FF00FF00CF8E
              68FFCF8E68FFCF8E68FFCF8E68FFCF8E68FFCF8E68FFCF8E68FFCF8E68FFCF8E
              68FFCF8E68FFCF8E68FFCF8E68FFCF8E68FFFF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            TabOrder = 0
            OnClick = btnExecutarClick
          end
          object btnCancelar: TcxButton
            Left = 88
            Top = 8
            Width = 75
            Height = 25
            Caption = '&Cancelar'
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00015603FF015603FF0156
              03FF015603FFFF00FF00000082FF000082FF000082FF000082FF000082FF0000
              82FF000082FF000082FF000082FF000082FF000082FF015603FF2DC651FF1DB2
              36FF015603FFFF00FF00000082FF011EF3FF0527FBFF1337FBFF3052FCFF5F7D
              FEFFA1B4FFFFF2F6FFFFFFFFFFFFFFFFFFFF000082FF015603FF3FD96DFF30C9
              56FF015603FFFF00FF00000082FF0120FBFF0528FCFF1438FCFF3154FEFF607F
              FFFFA5B7FFFFF6FAFFFFFFFFFFFFFFFFFFFF000082FF015603FF015603FF0156
              03FF015603FFFF00FF00000082FF000082FF000082FF000082FF000082FF0000
              82FF000082FF000082FF000082FF000082FF000082FFFF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00015603FF015603FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000156
              03FF41E074FF28AC47FF015603FF015603FFFF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00035A05FF015603FFFF00FF00FF00FF00FF00FF000156
              03FF2DC450FF35CE5DFF188F2CFF015603FFFF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00045F09FF188E2BFF015603FFFF00FF00FF00FF00015603FF0E8F
              1CFF19AB31FF22B53EFF035E07FFFF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF0005630AFF2DB750FF015603FFFF00FF00FF00FF00FF00FF00015603FF0156
              03FF036507FF11A322FF16A429FF046007FF025804FF015704FF045F08FF0E78
              19FF2FBC55FF015603FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00015603FF026305FF0A9815FF0FA01FFF0D891AFF108E1FFF1CA634FF2ABD
              4AFF015603FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00015603FF015603FF05840CFF088E11FF0D971AFF0D971AFF0156
              03FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00015603FF015603FF015603FF015603FFFF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            TabOrder = 1
            OnClick = btnCancelarClick
          end
          object btnSair: TcxButton
            Left = 560
            Top = 8
            Width = 75
            Height = 25
            Caption = '&Sair'
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E00000000000000000000FF00FF00088CC6FF088C
              C6FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00088CC6FF94E7F7FF5ADE
              EFFF088CC6FF088CC6FF088CC6FF088CC6FF088CC6FFFF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00088CC6FFA5E7F7FF8CFF
              FFFF84FFFFFF84F7FFFF84F7FFFF7BF7FFFF63DEFFFF088CC6FF088CC6FF006B
              08FF106B08FFFF00FF00FF00FF00FF00FF00FF00FF000894CEFF42ADD6FF9CFF
              FFFF73F7FFFF7BF7FFFF42B594FF219442FF21944AFF299C4AFF218C42FF007B
              10FF008C08FF087B18FFFF00FF00FF00FF00FF00FF0021A5D6FF42ADD6FF9CF7
              F7FF73F7FFFF84FFFFFF31945AFF29BD4AFF29BD4AFF21B542FF18AD42FF10A5
              31FF08A518FF009408FF006B00FFFF00FF00FF00FF0029A5D6FF5ADEEFFF42AD
              D6FF84FFFFFF84FFFFFF31945AFF31C652FF39D663FF29BD4AFF21B542FF21B5
              42FF10A531FF08A518FF008C08FF005200FFFF00FF0029A5D6FF7BEFF7FF42AD
              D6FFA5FFFFFF73FFFFFF42B594FF31AD5AFF29AD63FF29AD63FF088CC6FF10A5
              39FF18B552FF089C21FF108431FF088CC6FFFF00FF0029A5D6FF8CF7F7FF6BA5
              B5FF42ADD6FF94F7FFFF94F7FFFF94FFFFFF8CFFFFFF73F7FFFF73F7FFFF18A5
              31FF109429FF188442FF7BEFF7FF21A5D6FFFF00FF0029A5D6FF84F7F7FFDEBD
              ADFF42ADD6FF42ADD6FF42ADD6FF42ADD6FF42ADD6FF9CF7FFFF6BEFF7FF087B
              18FF31945AFF52CEF7FF84F7FFFF4ACEEFFFFF00FF0029A5D6FF84F7F7FFD6C6
              BDFFFFFFF7FFFFE7D6FFFFE7BDFFDED6B5FF9CBDB5FF42ADD6FF94E7F7FF73D6
              C6FF94F7FFFF6BDEFFFF94F7FFFF84F7FFFF189CD6FF29A5D6FF84F7F7FFD6C6
              BDFFFFFFFFFFFFEFE7FFF7E7D6FFF7E7C6FFFFDEB5FFB5C6B5FF42ADD6FF42AD
              D6FF42ADD6FF42ADD6FF42ADD6FF42ADD6FF31A5D6FF31A5D6FF84F7F7FFDECE
              C6FFFFFFFFFFFFFFF7FFFFEFE7FFF7E7D6FFF7E7C6FFFFDEB5FFFFD69CFF73A5
              ADFF5AEFFFFF189CD6FFFF00FF00FF00FF00FF00FF00299CD6FF9CF7F7FFE7D6
              C6FFFFFFFFFFFFFFFFFFFFFFF7FFFFEFE7FFF7E7D6FFAD7363FFAD7363FFAD73
              63FF219CD6FF219CD6FFFF00FF00FF00FF00FF00FF00FF00FF00299CD6FFEFD6
              C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7D6CEFFAD7363FFDE8442FFBD5A
              63FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7D6
              C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7D6DEFFAD7363FFDE8C52FFFF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DEA5
              84FFDEA584FFDEA584FFDEA584FFDEA584FFDEA584FFAD7363FFFF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            TabOrder = 2
            OnClick = btnSairClick
          end
        end
        object Panel1: TPanel
          Left = 0
          Top = 103
          Width = 650
          Height = 77
          Align = alTop
          TabOrder = 1
          object gpbPeriodo: TGroupBox
            Left = 0
            Top = 2
            Width = 353
            Height = 71
            Caption = ' Per'#237'odo '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label5: TLabel
              Left = 25
              Top = 32
              Width = 32
              Height = 13
              Caption = 'Inicio: '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label6: TLabel
              Left = 185
              Top = 32
              Width = 20
              Height = 13
              Caption = 'Fim:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object edtDtInicio: TcxDateEdit
              Left = 59
              Top = 28
              ParentFont = False
              Style.Font.Charset = DEFAULT_CHARSET
              Style.Font.Color = clWindowText
              Style.Font.Height = -11
              Style.Font.Name = 'Tahoma'
              Style.Font.Style = []
              Style.LookAndFeel.NativeStyle = False
              Style.IsFontAssigned = True
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.NativeStyle = False
              TabOrder = 0
              Width = 90
            end
            object edtDtFim: TcxDateEdit
              Left = 209
              Top = 28
              ParentFont = False
              Style.Font.Charset = DEFAULT_CHARSET
              Style.Font.Color = clWindowText
              Style.Font.Height = -11
              Style.Font.Name = 'Tahoma'
              Style.Font.Style = []
              Style.LookAndFeel.NativeStyle = False
              Style.IsFontAssigned = True
              StyleDisabled.LookAndFeel.NativeStyle = False
              StyleFocused.LookAndFeel.NativeStyle = False
              StyleHot.LookAndFeel.NativeStyle = False
              TabOrder = 1
              Width = 90
            end
          end
          object GroupBox1: TGroupBox
            Left = 359
            Top = 2
            Width = 291
            Height = 71
            Caption = 'Totalizadores'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object lblProcessados: TLabel
              Left = 89
              Top = 39
              Width = 35
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblProcessadosErros: TLabel
              Left = 249
              Top = 26
              Width = 7
              Height = 13
              Alignment = taRightJustify
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label7: TLabel
              Left = 11
              Top = 39
              Width = 74
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Processados:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label8: TLabel
              Left = 11
              Top = 52
              Width = 74
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Acertos:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGreen
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label9: TLabel
              Left = 151
              Top = 26
              Width = 64
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Erros:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblProcessadosAcertos: TLabel
              Left = 117
              Top = 52
              Width = 7
              Height = 13
              Alignment = taRightJustify
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGreen
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label10: TLabel
              Left = 151
              Top = 39
              Width = 64
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Ignorados:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clOlive
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label11: TLabel
              Left = 151
              Top = 52
              Width = 64
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Duplicados:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblProcessadosIgnorados: TLabel
              Left = 249
              Top = 39
              Width = 7
              Height = 13
              Alignment = taRightJustify
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clOlive
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblProcessadosDuplicados: TLabel
              Left = 249
              Top = 52
              Width = 7
              Height = 13
              Alignment = taRightJustify
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label12: TLabel
              Left = 11
              Top = 26
              Width = 74
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Registros:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblRegistros: TLabel
              Left = 89
              Top = 26
              Width = 35
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label13: TLabel
              Left = 3
              Top = 12
              Width = 82
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Processando:'
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clTeal
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
            end
            object lblProcessamentoAtual: TLabel
              Left = 91
              Top = 11
              Width = 162
              Height = 14
              AutoSize = False
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clTeal
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
            end
          end
        end
        object pnlMarDes: TPanel
          Left = 0
          Top = 180
          Width = 650
          Height = 20
          Align = alTop
          TabOrder = 2
          object chkMarDes: TCheckBox
            Left = 1
            Top = 1
            Width = 648
            Height = 16
            Align = alTop
            Caption = 'Marcar/Desmarcar Todos'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            TabOrder = 0
            OnClick = chkMarDesClick
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = '&Resumo'
      ImageIndex = 1
      object memResumo: TRichEdit
        Left = 0
        Top = 0
        Width = 650
        Height = 369
        Align = alClient
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        Zoom = 100
      end
    end
  end
end
