inherited frmFatItensRomaneioInform: TfrmFatItensRomaneioInform
  Left = 220
  Top = 276
  Width = 528
  Height = 249
  BorderIcons = [biSystemMenu]
  Caption = 'Informa'#231#245'es do Item'
  Position = poScreenCenter
  ExplicitWidth = 528
  ExplicitHeight = 249
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 177
    Width = 522
    ExplicitTop = 177
    ExplicitWidth = 522
    DesignSize = (
      522
      28)
    inherited btnSair: TBitBtnLocked
      Left = 429
      Width = 85
      ExplicitLeft = 429
      ExplicitWidth = 85
    end
    object btnConfirma: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 85
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 205
    Width = 522
    ExplicitTop = 205
    ExplicitWidth = 522
    inherited pnlNomeForm: TPanel
      Left = 351
      ExplicitLeft = 351
    end
    inherited pnlInfo: TPanel
      Width = 351
      ExplicitWidth = 351
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 522
    Height = 44
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblCodigo: TLabel
      Left = 75
      Top = 6
      Width = 43
      Height = 14
      Caption = 'lblCodigo'
    end
    object lblDescricao: TLabel
      Left = 75
      Top = 23
      Width = 59
      Height = 14
      Caption = 'lblDescricao'
    end
    object Label1: TLabel
      Left = 11
      Top = 6
      Width = 58
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Item:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 11
      Top = 23
      Width = 58
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object memInform: TMemoFocus [3]
    Left = 5
    Top = 48
    Width = 506
    Height = 119
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 72
  end
end
