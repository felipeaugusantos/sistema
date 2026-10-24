inherited frmFatFormulacaoMazaAutomotiva: TfrmFatFormulacaoMazaAutomotiva
  Left = 410
  Top = 324
  Width = 362
  Height = 374
  Caption = 'Formula'#231#227'o Maza Automotiva'
  Position = poScreenCenter
  OnActivate = FormActivate
  ExplicitWidth = 362
  ExplicitHeight = 374
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 333
    Width = 356
    ExplicitTop = 330
    ExplicitWidth = 356
    DesignSize = (
      356
      0)
    inherited btnSair: TBitBtnLocked
      Left = 235
      ExplicitLeft = 235
    end
  end
  inherited pnlStatus: TPanel
    Top = 333
    Width = 356
    ExplicitTop = 330
    ExplicitWidth = 356
    inherited pnlNomeForm: TPanel
      Left = 208
      Width = 148
      ExplicitLeft = 208
      ExplicitWidth = 148
    end
    inherited pnlInfo: TPanel
      Width = 208
      ExplicitWidth = 208
    end
  end
  inherited pgcDados: TPageControl
    Top = 104
    Width = 356
    Height = 229
    ExplicitTop = 104
    ExplicitWidth = 356
    ExplicitHeight = 226
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 348
      ExplicitHeight = 194
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 104
    Width = 356
    Height = 229
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitHeight = 226
    object dbgFormulacao: TDBGridCitel
      Left = 1
      Top = 1
      Width = 354
      Height = 196
      Align = alClient
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      Top = 197
      Width = 354
      Height = 28
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        354
        28)
      object btnCancelarForm: TBitBtnLocked
        Left = 233
        Top = 3
        Width = 111
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ Esc ] Cancelar'
        TabOrder = 1
        OnClick = btnCancelarFormClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 6
        Top = 4
        Width = 149
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F10 ] Imprimir Formula'#231#227'o'
        TabOrder = 0
        OnClick = btnImprimirClick
      end
    end
  end
  object memBase: TMemo [4]
    Left = 0
    Top = 0
    Width = 356
    Height = 104
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
end
