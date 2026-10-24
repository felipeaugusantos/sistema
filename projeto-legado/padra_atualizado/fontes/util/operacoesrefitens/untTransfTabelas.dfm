inherited frmTransfTabelas: TfrmTransfTabelas
  Width = 497
  Height = 184
  Caption = 'Transfer'#234'ncia de Pre'#231'os entre Tabelas'
  OnDestroy = FormDestroy
  ExplicitWidth = 497
  ExplicitHeight = 184
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 24
    Top = 16
    Width = 117
    Height = 14
    Caption = 'Tabela de Pre'#231'o Origem:'
  end
  object Label2: TLabel [1]
    Left = 175
    Top = 16
    Width = 119
    Height = 14
    Caption = 'Tabela de Pre'#231'o Destino:'
  end
  inherited pnlBotoes: TPanel
    Top = 112
    Width = 491
    TabOrder = 2
    ExplicitTop = 155
    ExplicitWidth = 491
    inherited btnSair: TBitBtnLocked
      Left = 408
      TabOrder = 1
      ExplicitLeft = 408
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 75
      Height = 22
      Caption = '&Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 140
    Width = 491
    TabOrder = 3
    ExplicitTop = 183
    ExplicitWidth = 491
    inherited pnlNomeForm: TPanel
      Left = 320
      ExplicitLeft = 320
    end
    inherited pnlInfo: TPanel
      Width = 320
      ExplicitWidth = 320
    end
  end
  object prgProgresso: TProgressBar [4]
    Left = 0
    Top = 95
    Width = 491
    Height = 17
    Align = alBottom
    Smooth = True
    TabOrder = 4
    ExplicitTop = 138
  end
  object cbxTabOri: TComboBox [5]
    Left = 24
    Top = 30
    Width = 145
    Height = 22
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 0
  end
  object cbxTabDes: TComboBox [6]
    Left = 175
    Top = 30
    Width = 145
    Height = 22
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 1
  end
  object Memo1: TMemo [7]
    Left = 0
    Top = 61
    Width = 491
    Height = 34
    Align = alBottom
    Color = clInfoBk
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      
        'Todas as informa'#231#245'es referentes aos pre'#231'os da Tabela Origem ser'#227 +
        'o copiadas para a'
      'Tabela Destino. ')
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    ExplicitTop = 104
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
  end
end
