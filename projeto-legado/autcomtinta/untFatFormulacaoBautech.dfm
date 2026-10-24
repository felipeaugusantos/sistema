inherited frmFatFormulacaoBautech: TfrmFatFormulacaoBautech
  Left = 425
  Top = 332
  Width = 416
  Height = 287
  Caption = 'Formula'#231#227'o - Bautech'
  Position = poScreenCenter
  OnActivate = FormActivate
  ExplicitWidth = 416
  ExplicitHeight = 287
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 243
    Width = 410
    ExplicitTop = 243
    ExplicitWidth = 410
    DesignSize = (
      410
      0)
    inherited btnSair: TBitBtnLocked
      Left = 242
      ExplicitLeft = 242
    end
  end
  inherited pnlStatus: TPanel
    Top = 243
    Width = 410
    ExplicitTop = 243
    ExplicitWidth = 410
    inherited pnlNomeForm: TPanel
      Left = 269
      Width = 141
      ExplicitLeft = 269
      ExplicitWidth = 141
    end
    inherited pnlInfo: TPanel
      Width = 269
      ExplicitWidth = 269
    end
  end
  inherited pgcDados: TPageControl
    Width = 410
    Height = 243
    ExplicitWidth = 410
    ExplicitHeight = 243
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 402
      ExplicitHeight = 211
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 410
    Height = 243
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object dbgFormulacao: TDBGridCitel
      Left = 1
      Top = 64
      Width = 408
      Height = 150
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = dbgFormulacaoKeyDown
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
      Top = 214
      Width = 408
      Height = 28
      Align = alBottom
      Color = 16770261
      TabOrder = 1
      DesignSize = (
        408
        28)
      object lblTipoFormulacao: TLabel
        Left = 154
        Top = 8
        Width = 130
        Height = 15
        Caption = 'Formula'#231#227'o em Pulsos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnCancelarForm: TBitBtnLocked
        Left = 291
        Top = 3
        Width = 111
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ Esc ] Cancelar'
        TabOrder = 0
        OnClick = btnCancelarFormClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 4
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
      Width = 408
      Height = 63
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
end
