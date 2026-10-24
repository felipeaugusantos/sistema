object frmEditorRelPrincipal: TfrmEditorRelPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Editor de Relat'#243'rios'
  ClientHeight = 611
  ClientWidth = 1065
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mnuPrincipal
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object mnuPrincipal: TMainMenu
    Left = 440
    Top = 40
    object mnuRelatorios: TMenuItem
      Caption = 'Relat'#243'rios'
      object mnuCadastrodeRelatorios: TMenuItem
        Caption = 'Cadastro de Relat'#243'rios'
        OnClick = mnuCadastrodeRelatoriosClick
      end
      object RelatriosCustomizadosdoMenu1: TMenuItem
        Caption = 'Relat'#243'rios Customizados do Menu'
        OnClick = RelatriosCustomizadosdoMenu1Click
      end
    end
    object mnuConsultas: TMenuItem
      Caption = 'Consultas'
    end
    object mnuModelos: TMenuItem
      Caption = 'Modelos'
      OnClick = mnuModelosClick
    end
    object mnuAssuntos: TMenuItem
      Caption = 'Assuntos'
    end
    object mnuSair: TMenuItem
      Caption = 'Sair'
      OnClick = mnuSairClick
    end
  end
end
