inherited frmCadSkyNovasFormulas: TfrmCadSkyNovasFormulas
  Left = 291
  Top = 213
  Width = 699
  Height = 530
  Caption = 'Cadastro de Novas F'#243'rmulas - Skymix'
  ExplicitWidth = 699
  ExplicitHeight = 530
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 458
    Width = 693
    ExplicitTop = 458
    ExplicitWidth = 693
    DesignSize = (
      693
      28)
    inherited btnSair: TBitBtnLocked
      Left = 616
      ExplicitLeft = 616
    end
    inherited btnIncluir: TBitBtnLocked
      Width = 65
      ExplicitWidth = 65
    end
    inherited btnGravar: TBitBtnLocked
      Left = 70
      Width = 65
      ExplicitLeft = 70
      ExplicitWidth = 65
    end
    inherited btnCancela: TBitBtnLocked
      Left = 267
      Width = 70
      ExplicitLeft = 267
      ExplicitWidth = 70
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 202
      Width = 65
      ExplicitLeft = 202
      ExplicitWidth = 65
    end
    inherited btnPesquisa: TBitBtnLocked
      Left = 338
      Width = 76
      ExplicitLeft = 338
      ExplicitWidth = 76
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 136
      Width = 65
      ExplicitLeft = 136
      ExplicitWidth = 65
    end
  end
  inherited pgcDados: TPageControl
    Width = 693
    Height = 458
    ExplicitWidth = 693
    ExplicitHeight = 458
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 685
      ExplicitHeight = 426
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 693
    Height = 458
    Align = alClient
    Color = 16770261
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 3
    object Label1: TLabel
      Left = 84
      Top = 35
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label3: TLabel
      Left = 86
      Top = 62
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo:'
    end
    object Label4: TLabel
      Left = 241
      Top = 62
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sub Grupo:'
    end
    object Label5: TLabel
      Left = 68
      Top = 86
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label6: TLabel
      Left = 217
      Top = 110
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ano:'
    end
    object Label7: TLabel
      Left = 66
      Top = 110
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Montadora:'
    end
    object Label8: TLabel
      Left = 83
      Top = 134
      Width = 37
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cor Pai:'
    end
    object Label9: TLabel
      Left = 405
      Top = 110
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Variante:'
    end
    object Label10: TLabel
      Left = 226
      Top = 134
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nacionalidade:'
    end
    object Label2: TLabel
      Left = 55
      Top = 159
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#227'o:'
    end
    object Label11: TLabel
      Left = 255
      Top = 184
      Width = 79
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo da F'#243'rmula:'
    end
    object Label28: TLabel
      Left = 224
      Top = 35
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Cadastro:'
    end
    object Label12: TLabel
      Left = 0
      Top = 184
      Width = 118
      Height = 14
      Alignment = taRightJustify
      Caption = 'Acr'#233'scimo m'#227'o de obra:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 32
      Width = 89
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeGrupo: TDBEditFocus
      Tag = 99
      Left = 123
      Top = 59
      Width = 90
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 2
      OnKeyPress = dbeGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSubGrupo: TDBEditFocus
      Tag = 99
      Left = 300
      Top = 59
      Width = 85
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 3
      OnKeyPress = dbeSubGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 83
      Width = 361
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAno: TDBEditFocus
      Tag = 99
      Left = 244
      Top = 107
      Width = 89
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodMon: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 107
      Width = 89
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 5
      OnKeyPress = dbeCodMonKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodPai: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 131
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVariante: TDBEditFocus
      Tag = 99
      Left = 452
      Top = 107
      Width = 33
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNacionalidade: TDBEditFocus
      Tag = 99
      Left = 300
      Top = 131
      Width = 33
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeObserv: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 156
      Width = 361
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 255
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAcrMob: TDBEditFocus
      Tag = 99
      Left = 124
      Top = 180
      Width = 93
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 691
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Novas F'#243'rmulas - Skymix'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 13
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 300
      Top = 30
      Width = 85
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'NFM_DTACAD'
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object Panel2: TPanel
      Left = 1
      Top = 208
      Width = 691
      Height = 249
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel2'
      TabOrder = 14
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 73
        Height = 249
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object btnAdicionarFormula: TBitBtnLocked
          Left = 3
          Top = 61
          Width = 65
          Height = 20
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
          OnClick = btnAdicionarFormulaClick
        end
        object btnExcluirformula: TBitBtnLocked
          Left = 3
          Top = 87
          Width = 65
          Height = 20
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
          OnClick = btnExcluirformulaClick
        end
      end
      object dbgBases: TDBGridCitel
        Tag = 99
        Left = 73
        Top = 0
        Width = 618
        Height = 249
        Align = alClient
        Ctl3D = True
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = dbgBasesKeyDown
        OnKeyPress = dbgBasesKeyPress
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'NFM_FORM'
            ReadOnly = True
            Title.Caption = 'C'#243'd. Base'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NFM_DESB'
            ReadOnly = True
            Title.Caption = 'Descri'#231#227'o'
            Width = 480
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NFM_QTDB'
            Title.Caption = 'Quantidade'
            Visible = True
          end>
      end
    end
    object cmbTipoFormula: TComboBox
      Left = 340
      Top = 180
      Width = 145
      Height = 22
      Style = csDropDownList
      TabOrder = 12
      Items.Strings = (
        'CONCENTRADO'
        'DILUIDO')
    end
  end
  inherited pnlStatus: TPanel
    Top = 486
    Width = 693
    ExplicitTop = 486
    ExplicitWidth = 693
    inherited pnlNomeForm: TPanel
      Left = 346
      ExplicitLeft = 346
    end
    inherited pnlInfo: TPanel
      Width = 346
      ExplicitWidth = 346
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 608
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 656
    Top = 152
  end
end
