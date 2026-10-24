inherited frmDigValor: TfrmDigValor
  Left = 592
  Top = 447
  Width = 323
  Height = 119
  Caption = 'Recebimento'
  Position = poScreenCenter
  ExplicitWidth = 323
  ExplicitHeight = 119
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 49
    Width = 317
    Height = 25
    TabOrder = 1
    Visible = True
    ExplicitTop = 49
    ExplicitWidth = 317
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 236
      Height = 21
      ExplicitWidth = 236
      ExplicitHeight = 21
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 22
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
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 238
      Top = 2
      Height = 21
      Align = alRight
      ExplicitLeft = 238
      ExplicitTop = 2
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 74
    Width = 317
    TabOrder = 2
    ExplicitTop = 74
    ExplicitWidth = 317
    inherited pnlNomeForm: TPanel
      Left = 212
      Width = 105
      ExplicitLeft = 212
      ExplicitWidth = 105
    end
    inherited pnlInfo: TPanel
      Width = 212
      ExplicitWidth = 212
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 317
    Height = 49
    Align = alClient
    ParentColor = True
    TabOrder = 3
    object lblUnitario: TLabel
      Left = 24
      Top = 14
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digite o valor:'
    end
    object edtValor: TEditFocus
      Tag = 99
      Left = 93
      Top = 11
      Width = 107
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      TabOrder = 0
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
    object cmbTipVal: TComboBoxFocus
      Left = 206
      Top = 11
      Width = 90
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Cr'#233'dito'
      Visible = False
      Items.Strings = (
        'Cr'#233'dito'
        'D'#233'bito')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited pgcDados: TPageControl
    Left = 3000
    Top = 204
    Width = 317
    Height = 46
    Align = alNone
    Visible = False
    ExplicitLeft = 3000
    ExplicitTop = 204
    ExplicitWidth = 317
    ExplicitHeight = 46
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 309
      ExplicitHeight = 14
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 392
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 368
    Top = 48
  end
end
