inherited frmMensagemTabela: TfrmMensagemTabela
  ClientHeight = 290
  ClientWidth = 453
  ExplicitWidth = 469
  ExplicitHeight = 328
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPrincipal: TPanel
    Width = 453
    Height = 290
    ExplicitWidth = 453
    ExplicitHeight = 290
    inherited pnlMensagem: TPanel
      Width = 451
      Height = 219
      ExplicitWidth = 451
      ExplicitHeight = 219
      inherited lblMensagem: TLabel
        Top = 168
        Width = 449
        Height = 50
        Align = alBottom
        ExplicitTop = 159
        ExplicitWidth = 449
        ExplicitHeight = 50
      end
      object pnlTabela: TPanel
        Left = 1
        Top = 1
        Width = 449
        Height = 167
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        ExplicitHeight = 152
        object lsvTabela: TListView
          Left = 0
          Top = 0
          Width = 449
          Height = 167
          Align = alClient
          Columns = <
            item
              Width = 425
            end>
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ReadOnly = True
          ParentFont = False
          TabOrder = 0
          ViewStyle = vsReport
          ExplicitHeight = 152
        end
      end
    end
    inherited pblTitulo: TPanel
      Width = 451
      ExplicitWidth = 451
      inherited lblTitulo: TLabel
        Width = 449
        Height = 28
      end
    end
    inherited pnlBotoes: TPanel
      Top = 250
      Width = 451
      ExplicitTop = 250
      ExplicitWidth = 451
    end
  end
  inherited popAreaTransf: TPopupMenu
    Left = 392
  end
end
