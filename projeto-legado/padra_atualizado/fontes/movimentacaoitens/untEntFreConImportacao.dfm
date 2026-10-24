inherited frmEntFreConImportacao: TfrmEntFreConImportacao
  Left = 238
  Top = 354
  Width = 719
  Height = 520
  BorderStyle = bsDialog
  Caption = 'Importa'#231#227'o de Conhecimentos de Frete'
  Position = poMainFormCenter
  ExplicitWidth = 719
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 14
  inherited pgcDados: TPageControl [0]
    Left = 120
    Top = 312
    Width = 225
    Height = 33
    Align = alNone
    TabOrder = 8
    Visible = False
    ExplicitLeft = 120
    ExplicitTop = 312
    ExplicitWidth = 225
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 217
      ExplicitHeight = 1
    end
  end
  object pnlTopo: TPanel [1]
    Left = 0
    Top = 0
    Width = 713
    Height = 133
    Align = alClient
    BevelOuter = bvSpace
    Color = 16770261
    TabOrder = 0
    ExplicitLeft = 2
    ExplicitTop = -5
    object Label4: TLabel
      Left = 28
      Top = 80
      Width = 59
      Height = 14
      Hint = '999'
      Alignment = taRightJustify
      Caption = 'Dta Entrada:'
    end
    object Label6: TLabel
      Left = 166
      Top = 80
      Width = 43
      Height = 14
      Hint = '999'
      Alignment = taRightJustify
      Caption = 'Cnd.Pag:'
    end
    object Label30: TLabel
      Left = 43
      Top = 34
      Width = 44
      Height = 14
      Hint = '888'
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label1: TLabel
      Left = 46
      Top = 102
      Width = 41
      Height = 14
      Hint = '999'
      Caption = 'Arquivo:'
    end
    object lblCliFor: TLabel
      Left = 10
      Top = 11
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Transportadora:'
    end
    object mskDtaEnt: TMaskEditFocus
      Tag = 99
      Left = 91
      Top = 75
      Width = 69
      Height = 22
      Hint = '999'
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskConPag: TMaskEditFocus
      Tag = 99
      Left = 212
      Top = 75
      Width = 297
      Height = 22
      Hint = '999'
      AutoSize = False
      EditMask = '(99)999.999.999.999.999.999.999.999.999.999.999.999;0;_'
      MaxLength = 51
      TabOrder = 5
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 91
      Top = 29
      Width = 69
      Height = 22
      Hint = '888'
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 2
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomPor: TEditFocus
      Left = 162
      Top = 29
      Width = 347
      Height = 22
      Hint = '888'
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodTra: TEditFocus
      Tag = 99
      Left = 91
      Top = 6
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 0
      OnKeyPress = edtCodTraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesTra: TEditFocus
      Left = 162
      Top = 6
      Width = 347
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object flnArqTxt: TFilenameEditFocus
      Left = 91
      Top = 98
      Hint = '999'
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E0000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000004020FF406040FF406040FF4060
            40FF004020FF0000000000000000000000000000000000000000806040FFC080
            60FFC06060FFC0A080FFA4A0A0FF408060FF40A080FF40C080FF40C080FF40C0
            80FF40A060FF408060FF00000000000000000000000000000000C08060FFFFFF
            FFFFFFFFFFFFC0DCC0FF408060FF40C0A0FF40C0A0FF40A060FF408060FF40A0
            60FF40C0A0FF40C080FF408060FF000000000000000000000000C08060FFFFFF
            FFFFF0FBFFFF80A0A0FF40C0A0FF40E0A0FF40C0A0FF408060FFFFFFFFFF4080
            60FF40E0A0FF40C0A0FF40A080FF004040FF0000000000000000C08060FFFFFF
            FFFFF0FBFFFF40A080FF80E0C0FF40A080FF408060FF408060FFF0FBFFFF4080
            60FF408060FF40A080FF40C0A0FF408060FF0000000000000000C08060FFFFFF
            FFFFFFFFFFFF40A060FF80E0C0FF408060FFC0DCC0FFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF408060FF40E0A0FF408060FF0000000000000000C08060FFFFFF
            FFFFFFFFFFFF40A080FFC0DCC0FF80A080FF408060FF408060FFFFFFFFFF4080
            60FF408060FF40A080FF80E0C0FF408060FF0000000000000000C08080FFFFFF
            FFFFFFFFFFFF80C0A0FF80C0C0FFF0FBFFFFF0FBFFFF40A080FFF0FBFFFF40A0
            80FFC0DCC0FFC0DCC0FF80C0A0FF406040FF0000000000000000C08080FFFFFF
            FFFFFFFFFFFFF0FBFFFF40A080FFC0DCC0FFF0FBFFFF80C0A0FF40A080FF80A0
            A0FFF0FBFFFFC0DCC0FF40A080FF000000000000000000000000C08080FFFFFF
            FFFFFFFFFFFFFFFFFFFFC0DCC0FF40A080FF80C0C0FFF0FBFFFFF0FBFFFFF0FB
            FFFF80C0C0FF40A080FF004020FF000000000000000000000000C08080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FBFFFF80C0C0FF40C080FF40A080FF40C0
            80FF80C0C0FFC0C0C0FF00000000000000000000000000000000C0A080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC0A080FF00000000000000000000000000000000C0A080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC08080FF00000000000000000000000000000000C0A080FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFC0A080FF00000000000000000000000000000000808060FFC0A0
            80FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A0
            80FFC0A080FF808060FF000000000000000000000000}
          Kind = bkGlyph
        end>
      StyleFocused.Color = clInfoBk
      TabOrder = 7
      Width = 418
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = -1
      Top = 52
      Width = 551
      Height = 22
      TabOrder = 3
      ExplicitLeft = -1
      ExplicitTop = 52
      inherited lblPlaContas: TLabel
        Left = 57
        Width = 31
        Height = 14
        Caption = 'Conta:'
        ExplicitLeft = 57
        ExplicitWidth = 31
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 163
        Width = 347
        Height = 22
        ExplicitLeft = 163
        ExplicitWidth = 347
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Width = 69
        Height = 22
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitWidth = 69
        ExplicitHeight = 22
      end
    end
  end
  inherited pnlBotoes: TPanel [3]
    Top = 449
    Width = 713
    Height = 26
    Enabled = True
    TabOrder = 1
    Visible = True
    ExplicitTop = 449
    ExplicitWidth = 713
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 99
      Width = 516
      Height = 22
      TabOrder = 2
      ExplicitLeft = 99
      ExplicitWidth = 516
      ExplicitHeight = 22
    end
    inherited btnSair: TBitBtnLocked
      Left = 615
      Top = 2
      Width = 96
      Align = alRight
      ExplicitLeft = 615
      ExplicitTop = 2
      ExplicitWidth = 96
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 97
      Height = 22
      Align = alLeft
      Caption = '&Confirma'
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
      OnClick = btnConfirmaClick
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 291
    Width = 713
    Height = 19
    Align = alBottom
    Caption = 'Log Inconsist'#234'ncias'
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
  end
  object memErr: TMemo [5]
    Left = 0
    Top = 310
    Width = 713
    Height = 139
    TabStop = False
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
    WordWrap = False
  end
  object memLog: TMemo [6]
    Left = 0
    Top = 152
    Width = 713
    Height = 139
    TabStop = False
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
    WordWrap = False
  end
  object Panel1: TPanel [7]
    Left = 0
    Top = 133
    Width = 713
    Height = 19
    Align = alBottom
    Caption = 'Log Importa'#231#227'o'
    ParentBackground = False
    ParentColor = True
    TabOrder = 7
  end
  inherited pnlStatus: TPanel
    Top = 475
    Width = 713
    TabOrder = 2
    ExplicitTop = 475
    ExplicitWidth = 713
    inherited pnlNomeForm: TPanel
      Left = 542
      ExplicitLeft = 542
    end
    inherited pnlInfo: TPanel
      Width = 542
      ExplicitWidth = 542
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 632
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 632
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 648
    Top = 8
  end
end
