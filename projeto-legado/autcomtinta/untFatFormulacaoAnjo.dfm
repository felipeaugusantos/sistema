inherited frmFatFormulacaoAnjo: TfrmFatFormulacaoAnjo
  Width = 369
  Height = 374
  Caption = 'Formula'#231#227'o - Anjo'
  Position = poScreenCenter
  ExplicitWidth = 369
  ExplicitHeight = 374
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 305
    Width = 363
    ExplicitTop = 302
    ExplicitWidth = 363
    DesignSize = (
      363
      0)
  end
  inherited pnlStatus: TPanel
    Top = 333
    Width = 363
    ExplicitTop = 330
    ExplicitWidth = 363
    inherited pnlNomeForm: TPanel
      Left = 192
      ExplicitLeft = 192
    end
    inherited pnlInfo: TPanel
      Width = 192
      ExplicitWidth = 192
    end
  end
  inherited pgcDados: TPageControl
    Top = 104
    Width = 363
    Height = 201
    ExplicitTop = 104
    ExplicitWidth = 363
    ExplicitHeight = 198
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 355
      ExplicitHeight = 166
    end
  end
  object memBase: TMemo [3]
    Left = 0
    Top = 0
    Width = 363
    Height = 104
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object dbgFormulacao: TDBGridCitel [4]
    Left = 0
    Top = 104
    Width = 363
    Height = 201
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgFormulacaoKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'TMP_FORMUL'
        Title.Caption = 'Formula'#231#227'o'
        Width = 250
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TMP_QTDBAS'
        Title.Caption = 'Quantidade'
        Width = 70
        Visible = True
      end>
  end
  object pnlBotoesFor: TPanel [5]
    Left = 0
    Top = 305
    Width = 363
    Height = 28
    Align = alBottom
    Color = 16770261
    TabOrder = 5
    ExplicitTop = 302
    DesignSize = (
      363
      28)
    object btnCancelarForm: TBitBtnLocked
      Left = 242
      Top = 3
      Width = 111
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '[ Esc ] Cancelar'
      TabOrder = 0
      OnClick = btnCancelarFormClick
    end
    object btnImprimir: TBitBtnLocked
      Left = 8
      Top = 4
      Width = 149
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '[ F10 ] Etiqueta Formula'#231#227'o'
      TabOrder = 1
      OnClick = btnImprimirClick
    end
  end
end
