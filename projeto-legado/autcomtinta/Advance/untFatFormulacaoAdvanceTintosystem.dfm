inherited frmFatFormulacaoAdvanceTintosystem: TfrmFatFormulacaoAdvanceTintosystem
  Left = 386
  Top = 245
  Width = 369
  Height = 374
  Caption = 'Formula'#231#227'o - AdvanceTintosystem'
  Position = poScreenCenter
  ExplicitWidth = 369
  ExplicitHeight = 374
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 333
    Width = 363
    ExplicitTop = 330
    ExplicitWidth = 363
    DesignSize = (
      363
      0)
    inherited btnSair: TBitBtnLocked
      Left = 242
      ExplicitLeft = 242
    end
  end
  inherited pnlStatus: TPanel
    Top = 333
    Width = 363
    ExplicitTop = 330
    ExplicitWidth = 363
    inherited pnlNomeForm: TPanel
      Left = 222
      Width = 141
      ExplicitLeft = 222
      ExplicitWidth = 141
    end
    inherited pnlInfo: TPanel
      Width = 222
      ExplicitWidth = 222
    end
  end
  inherited pgcDados: TPageControl
    Width = 363
    Height = 333
    ExplicitWidth = 363
    ExplicitHeight = 330
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 363
    Height = 333
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 330
    object dbgFormulacao: TDBGridCitel
      Left = 1
      Top = 105
      Width = 361
      Height = 196
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
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
    object pnlBotoesFor: TPanel
      Left = 1
      Top = 301
      Width = 361
      Height = 28
      Align = alBottom
      Color = 16770261
      TabOrder = 1
      DesignSize = (
        361
        28)
      object btnCancelarForm: TBitBtnLocked
        Left = 240
        Top = 3
        Width = 111
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ Esc ] Cancelar'
        TabOrder = 0
        OnClick = btnCancelarFormClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 6
        Top = 4
        Width = 149
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F10 ] Etiqueta Formula'#231#227'o'
        TabOrder = 1
        OnClick = btnImprimirClick
      end
    end
    object memBase: TMemo
      Left = 1
      Top = 1
      Width = 361
      Height = 104
      Align = alTop
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 264
    Top = 32
  end
end
