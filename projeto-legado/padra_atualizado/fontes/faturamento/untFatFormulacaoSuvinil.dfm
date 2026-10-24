inherited frmFatFormulacaoSuvinil: TfrmFatFormulacaoSuvinil
  Left = 425
  Top = 332
  Width = 369
  Height = 248
  ActiveControl = nil
  Caption = 'Formula'#231#227'o - Suvinil'
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 205
    Width = 361
    inherited btnSair: TBitBtn
      Left = 242
    end
  end
  inherited pnlStatus: TPanel
    Top = 205
    Width = 361
    inherited pnlNomeForm: TPanel
      Left = 220
      Width = 141
    end
    inherited pnlInfo: TPanel
      Width = 220
    end
  end
  inherited pgcDados: TPageControl
    Width = 361
    Height = 205
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 361
    Height = 205
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object dbgFormulacao: TDBGridCitel
      Left = 1
      Top = 1
      Width = 359
      Height = 175
      Align = alClient
      DataSource = frmModuloSPR.dtsTemporaria3
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
      Top = 176
      Width = 359
      Height = 28
      Align = alBottom
      Color = 16770261
      TabOrder = 1
      DesignSize = (
        359
        28)
      object btnCancelarForm: TBitBtn
        Left = 238
        Top = 3
        Width = 111
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ Esc ] Cancelar'
        TabOrder = 0
        OnClick = btnCancelarFormClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 264
    Top = 32
  end
end
