inherited frmFatFormulacaoSherwinWhilliams: TfrmFatFormulacaoSherwinWhilliams
  Left = 425
  Top = 332
  Width = 421
  Height = 287
  Caption = 'Formula'#231#227'o - SherwinWhilliams'
  Position = poScreenCenter
  OnActivate = FormActivate
  ExplicitWidth = 421
  ExplicitHeight = 287
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 243
    Width = 415
    ExplicitTop = 243
    ExplicitWidth = 415
    DesignSize = (
      415
      0)
    inherited btnSair: TBitBtnLocked
      Left = 242
      ExplicitLeft = 242
    end
  end
  inherited pnlStatus: TPanel
    Top = 243
    Width = 415
    ExplicitTop = 243
    ExplicitWidth = 415
    inherited pnlNomeForm: TPanel
      Left = 274
      Width = 141
      ExplicitLeft = 274
      ExplicitWidth = 141
    end
    inherited pnlInfo: TPanel
      Width = 274
      ExplicitWidth = 274
    end
  end
  inherited pgcDados: TPageControl
    Width = 415
    Height = 243
    ExplicitWidth = 415
    ExplicitHeight = 243
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 407
      ExplicitHeight = 211
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 415
    Height = 243
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object dbgFormulacao: TDBGridCitel
      Left = 1
      Top = 64
      Width = 413
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
          Width = 304
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
      Width = 413
      Height = 28
      Align = alBottom
      Color = 16770261
      TabOrder = 1
      object lblTipoFormulacao: TLabel
        Left = 161
        Top = 6
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
        Left = 297
        Top = 4
        Width = 111
        Height = 22
        Caption = '[ Esc ] Cancelar'
        TabOrder = 0
        OnClick = btnCancelarFormClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 6
        Top = 4
        Width = 149
        Height = 22
        Caption = '[ F10 ] Etiqueta Formula'#231#227'o'
        TabOrder = 1
        OnClick = btnImprimirClick
      end
    end
    object memBase: TMemo
      Left = 1
      Top = 1
      Width = 413
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 264
    Top = 32
  end
end
