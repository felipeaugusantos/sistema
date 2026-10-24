object frmPrincipal: TfrmPrincipal
  Left = 321
  Top = 383
  Caption = 'Gera Script Relat'#243'rio'
  ClientHeight = 171
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 107
    Align = alClient
    BevelInner = bvLowered
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 22
      Height = 13
      Caption = 'Host'
    end
    object Label2: TLabel
      Left = 144
      Top = 8
      Width = 31
      Height = 13
      Caption = 'Banco'
    end
    object lblUser: TLabel
      Left = 144
      Top = 44
      Width = 36
      Height = 13
      Caption = 'Usuario'
    end
    object lblSenha: TLabel
      Left = 229
      Top = 44
      Width = 31
      Height = 13
      Caption = 'Senha'
    end
    object Label3: TLabel
      Left = 17
      Top = 44
      Width = 25
      Height = 13
      Caption = 'Porta'
    end
    object edtHost: TEditFocus
      Left = 16
      Top = 21
      Width = 121
      Height = 19
      Alignment = taLeftJustify
      Ctl3D = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 0
      Text = '10.0.0.205'
      OnKeyDown = edtHostKeyDown
      OnKeyPress = edtHostKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBanco: TEditFocus
      Left = 144
      Top = 21
      Width = 193
      Height = 19
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Ctl3D = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 1
      Text = 'AUTCOM_379_48_02_30'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUser: TEditFocus
      Left = 144
      Top = 58
      Width = 79
      Height = 19
      Alignment = taLeftJustify
      Ctl3D = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 3
      Text = 'root'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSenha: TEditFocus
      Left = 229
      Top = 59
      Width = 108
      Height = 19
      Alignment = taLeftJustify
      Ctl3D = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      PasswordChar = '*'
      TabOrder = 4
      Text = 'citel13347'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object stbLog: TStatusBar
      Left = 2
      Top = 86
      Width = 580
      Height = 19
      Panels = <
        item
          Width = 50
        end
        item
          Width = 50
        end>
    end
    object edtNumPor: TEditFocus
      Left = 17
      Top = 58
      Width = 121
      Height = 19
      Alignment = taLeftJustify
      Ctl3D = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 2
      Text = '47306'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object chbLibUti: TCheckBox
      Left = 343
      Top = 63
      Width = 97
      Height = 17
      Caption = 'Utilizar libUtil.dll'
      TabOrder = 6
      OnClick = chbLibUtiClick
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 117
    Width = 584
    Height = 54
    Align = alBottom
    BevelInner = bvLowered
    Color = clNavy
    ParentBackground = False
    TabOrder = 1
    object btnConvert: TBitBtnLocked
      Left = 6
      Top = 7
      Width = 89
      Height = 41
      Caption = 'Converte'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConvertClick
    end
    object btnSair: TBitBtnLocked
      Left = 490
      Top = 6
      Width = 89
      Height = 41
      Cancel = True
      Caption = 'Sair'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333FFFFF333333000033333388888833333333333F888888FFF333
        000033338811111188333333338833FFF388FF33000033381119999111833333
        38F338888F338FF30000339119933331111833338F388333383338F300003391
        13333381111833338F8F3333833F38F3000039118333381119118338F38F3338
        33F8F38F000039183333811193918338F8F333833F838F8F0000391833381119
        33918338F8F33833F8338F8F000039183381119333918338F8F3833F83338F8F
        000039183811193333918338F8F833F83333838F000039118111933339118338
        F3833F83333833830000339111193333391833338F33F8333FF838F300003391
        11833338111833338F338FFFF883F83300003339111888811183333338FF3888
        83FF83330000333399111111993333333388FFFFFF8833330000333333999999
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnSairClick
    end
  end
  object pgbStatus: TProgressBar
    Left = 0
    Top = 107
    Width = 584
    Height = 10
    Align = alBottom
    Smooth = True
    TabOrder = 2
  end
end
