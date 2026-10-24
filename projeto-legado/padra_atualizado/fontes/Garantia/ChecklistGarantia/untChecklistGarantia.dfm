inherited frmChecklistGarantia: TfrmChecklistGarantia
  Width = 1010
  Height = 457
  Caption = 'ChecklistGarantia'
  Position = poMainFormCenter
  ExplicitWidth = 1010
  ExplicitHeight = 457
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 384
    Width = 1004
    ExplicitTop = 384
    ExplicitWidth = 1004
    inherited FlwBotoes: TFlowPanel
      Width = 1000
      ExplicitWidth = 1000
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 94
        Height = 22
        Caption = '[F10] Confirmar'
        ModalResult = 1
        TabOrder = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 924
      ExplicitLeft = 924
    end
  end
  inherited pnlStatus: TPanel
    Top = 412
    Width = 1004
    ExplicitTop = 412
    ExplicitWidth = 1004
    inherited pnlNomeForm: TPanel
      Left = 833
      ExplicitLeft = 833
    end
    inherited pnlInfo: TPanel
      Width = 833
      ExplicitWidth = 833
    end
  end
  object pnlEdicao: TPanel [2]
    Left = 0
    Top = 0
    Width = 1004
    Height = 169
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlEdicao'
    TabOrder = 2
    inline fraEdicaockl: TfraEdicaoChecklistGarantia
      Left = 0
      Top = 0
      Width = 1004
      Height = 169
      Align = alClient
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitWidth = 1004
      ExplicitHeight = 169
      inherited pnlChkGarPrincipal: TPanel
        Width = 1004
        ShowCaption = False
        ExplicitWidth = 1004
        inherited lblTituloChecklist: TLabel
          Width = 998
        end
        inherited pnlChkGarPrincipal1: TPanel
          Width = 1004
          ExplicitWidth = 1004
          inherited lblChkGarDescri: TLabel
            Left = 189
            Width = 52
            Height = 14
            ExplicitLeft = 189
            ExplicitWidth = 52
            ExplicitHeight = 14
          end
          inherited lblChkGarCodigo: TLabel
            Left = 4
            Width = 36
            Height = 14
            ExplicitLeft = 4
            ExplicitWidth = 36
            ExplicitHeight = 14
          end
          inherited edtChkGarCodigo: TEditFocus
            Height = 22
            OnExit = fraEdicaockledtChkGarCodigoExit
            ExplicitHeight = 22
          end
          inherited edtChkGarDescricao: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
        end
        inherited pnlChkGarPrincipal2: TPanel
          Width = 1004
          ExplicitWidth = 1004
          inherited pnlChkGarPrincipal2Dir: TPanel
            Width = 619
            ExplicitWidth = 619
            inherited lblChkGarCarateresMemo: TLabel
              Height = 14
              ExplicitHeight = 14
            end
            inherited lblchkGarConteudo: TLabel
              Left = 10
              Width = 49
              Height = 14
              ExplicitLeft = 10
              ExplicitWidth = 49
              ExplicitHeight = 14
            end
            inherited mmoChkGarConteudo: TMemoFocus
              OnChange = fraEdicaocklmmoChkGarConteudoChange
            end
            inherited btnChkGarConfirmar: TBitBtnLocked
              OnClick = fraEdicaocklbtnChkGarConfirmarClick
            end
          end
        end
      end
    end
  end
  object pnlChecklist: TPanel [3]
    Left = 0
    Top = 169
    Width = 1004
    Height = 215
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlChecklist'
    ShowCaption = False
    TabOrder = 3
    inline fraChecklist: TframeCheckListGarantiaMercadoria
      Left = 0
      Top = 0
      Width = 1004
      Height = 215
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 1004
      ExplicitHeight = 215
      inherited pnlFraChkGar: TPanel
        Width = 1002
        Height = 213
        ExplicitWidth = 1002
        ExplicitHeight = 213
        inherited Label1: TLabel
          Width = 995
          Font.Pitch = fpVariable
        end
        inherited lblDelete: TLabel
          Top = 168
          Width = 1002
          Height = 14
          ExplicitWidth = 1002
          ExplicitHeight = 14
        end
        inherited pnlFraChkGarBtn: TPanel
          Top = 182
          Width = 1002
          ExplicitTop = 182
          ExplicitWidth = 1002
          inherited btnEditar: TBitBtnLocked
            OnClick = fraChecklistbtnEditarClick
          end
          inherited btnExtrairJson: TBitBtnLocked
            OnClick = fraChecklistbtnExtrairJsonClick
          end
        end
        inherited cxGrid1: TcxGrid
          Width = 1002
          Height = 150
          ExplicitWidth = 1002
          ExplicitHeight = 150
          inherited cxGrid1DBTableView1: TcxGridDBTableView
            OnCellClick = fraChecklistcxGrid1DBTableView1CellClick
            inherited cxGrid1DBTableView1ITE_CONTEU: TcxGridDBColumn
              Width = 617
            end
          end
        end
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 336
    Top = 112
  end
end
