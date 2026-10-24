inherited frmFatFormulacaoSkyMixAutomotiva: TfrmFatFormulacaoSkyMixAutomotiva
  Left = 410
  Top = 324
  Width = 408
  Height = 387
  Caption = 'Formula'#231#227'o SkyMix Automotiva'
  Position = poScreenCenter
  OnActivate = FormActivate
  ExplicitWidth = 408
  ExplicitHeight = 387
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 346
    Width = 402
    ExplicitTop = 343
    ExplicitWidth = 402
    DesignSize = (
      402
      0)
    inherited btnSair: TBitBtnLocked
      Left = 235
      ExplicitLeft = 235
    end
  end
  inherited pnlStatus: TPanel
    Top = 346
    Width = 402
    ExplicitTop = 343
    ExplicitWidth = 402
    inherited pnlNomeForm: TPanel
      Left = 254
      Width = 148
      ExplicitLeft = 254
      ExplicitWidth = 148
    end
    inherited pnlInfo: TPanel
      Width = 254
      ExplicitWidth = 254
    end
  end
  inherited pgcDados: TPageControl
    Width = 402
    Height = 346
    ExplicitWidth = 402
    ExplicitHeight = 343
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 394
      ExplicitHeight = 311
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 402
    Height = 346
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitHeight = 343
    object dbgFormulacao: TDBGridCitel
      Left = 1
      Top = 1
      Width = 400
      Height = 313
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -16
      TitleFont.Name = 'Courier New'
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
          Width = 103
          Visible = True
        end>
    end
    object pnlBotoesFor: TPanel
      Left = 1
      Top = 314
      Width = 400
      Height = 28
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        400
        28)
      object btnCancelarForm: TBitBtnLocked
        Left = 285
        Top = 3
        Width = 111
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ Esc ] Cancelar'
        TabOrder = 1
        OnClick = btnCancelarFormClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 4
        Top = 4
        Width = 149
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F10 ] Etiqueta Formula'#231#227'o'
        TabOrder = 0
        OnClick = btnImprimirClick
      end
    end
  end
end
