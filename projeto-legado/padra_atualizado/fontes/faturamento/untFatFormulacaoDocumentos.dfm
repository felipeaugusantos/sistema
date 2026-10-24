inherited frmFatFormulacaoDocumentos: TfrmFatFormulacaoDocumentos
  Left = 39
  Top = 10
  Width = 750
  Height = 550
  ActiveControl = nil
  BorderIcons = [biSystemMenu]
  Caption = 'Documentos para Formula'#231#245'es'
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 479
    Width = 742
    TabOrder = 4
    inherited btnSair: TBitBtn
      Left = 575
    end
  end
  inherited pnlStatus: TPanel
    Top = 507
    Width = 742
    TabOrder = 3
    inherited pnlNomeForm: TPanel
      Left = 536
      Width = 206
    end
    inherited pnlInfo: TPanel
      Width = 536
    end
  end
  inherited pgcDados: TPageControl
    Width = 742
    Height = 479
    TabOrder = 2
    Visible = False
  end
  object dbgDocumentos: TDBGridCitel [3]
    Left = 0
    Top = 0
    Width = 742
    Height = 479
    Align = alClient
    DataSource = frmModuloSPR.dtsTemporaria
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgDocumentosKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'GER_NUMDOC'
        Title.Caption = 'Documento'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_ESPDOC'
        Title.Caption = 'Esp'#233'cie'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODEMP'
        Title.Caption = 'Emp.'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NOMCLI'
        Title.Caption = 'C'#243'digo / Nome do Cliente'
        Width = 380
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_DTAENT'
        Title.Caption = 'Dta. Ent.'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODVEN'
        Title.Caption = 'Vendedor'
        Visible = True
      end>
  end
  object pnlBotoesFor: TPanel [4]
    Left = 0
    Top = 479
    Width = 742
    Height = 28
    Align = alBottom
    Color = 16770261
    TabOrder = 1
    DesignSize = (
      742
      28)
    object btnCancelarForm: TBitBtn
      Left = 627
      Top = 3
      Width = 111
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '[ Esc ] Cancelar'
      TabOrder = 0
      OnClick = btnCancelarFormClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 8
  end
end
