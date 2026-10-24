inherited frmCadPerfilAduaneiro: TfrmCadPerfilAduaneiro
  Width = 729
  Height = 310
  Caption = 'Cadastro de Perfil Aduaneiro'
  OnDestroy = FormDestroy
  ExplicitWidth = 729
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 237
    Width = 723
    TabOrder = 2
    ExplicitTop = 237
    ExplicitWidth = 723
    inherited FlwBotoes: TFlowPanel
      Width = 719
      ExplicitTop = 2
      ExplicitWidth = 719
      inherited btnIncluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 642
      ExplicitLeft = 642
    end
  end
  inherited pnlStatus: TPanel
    Top = 265
    Width = 723
    TabOrder = 3
    ExplicitTop = 265
    ExplicitWidth = 723
    inherited pnlNomeForm: TPanel
      Left = 376
      ExplicitLeft = 376
    end
    inherited pnlInfo: TPanel
      Width = 376
      ExplicitWidth = 376
    end
  end
  inherited pgcDados: TPageControl
    Width = 1
    Height = 1
    Align = alNone
    TabOrder = 4
    Visible = False
    ExplicitWidth = 1
    ExplicitHeight = 1
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object pnlContainer: TPanel [3]
    Left = 0
    Top = 41
    Width = 723
    Height = 196
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object rdgValUnitarProduto: TRadioGroup
      Left = 0
      Top = 130
      Width = 723
      Height = 55
      Align = alTop
      Caption = 'Considerar o Valor Unit'#225'rio do Produto pela:'
      Enabled = False
      ItemIndex = 0
      Items.Strings = (
        
          'Base de Calculo do II = Tag <det><imposto><II><vBC> Dividio Pela' +
          ' Quantidade Comercial <det><prod><qCom>'
        'Valor Unit'#225'rio Comercial = Tag <det><prod><vUnCom>')
      TabOrder = 2
    end
    object grpOutras: TGroupBox
      Left = 0
      Top = 74
      Width = 723
      Height = 56
      Align = alTop
      Caption = 'Composi'#231#227'o do Valor Outros da Nota Fiscal'
      TabOrder = 1
      object chkOutSiscomex: TCheckBox
        Left = 112
        Top = 33
        Width = 97
        Height = 17
        Caption = 'Siscomex'
        TabOrder = 3
      end
      object chkOutAfrmm: TCheckBox
        Left = 215
        Top = 16
        Width = 97
        Height = 17
        Caption = 'AFRMM'
        TabOrder = 4
      end
      object chkOutCofins: TCheckBox
        Left = 9
        Top = 33
        Width = 97
        Height = 17
        Caption = 'COFINS'
        TabOrder = 1
      end
      object chkOutPIS: TCheckBox
        Left = 9
        Top = 16
        Width = 97
        Height = 17
        Caption = 'PIS'
        TabOrder = 0
      end
      object chkOutIOF: TCheckBox
        Left = 112
        Top = 16
        Width = 97
        Height = 17
        Caption = 'IOF'
        TabOrder = 2
      end
      object chkOutDesAdu: TCheckBox
        Left = 215
        Top = 33
        Width = 160
        Height = 17
        Caption = 'Despesas Aduaneiras'
        TabOrder = 5
      end
    end
    object grpValorContabil: TGroupBox
      Left = 0
      Top = 0
      Width = 723
      Height = 74
      Align = alTop
      Caption = 'Composi'#231#227'o do Valor Cont'#225'bil da Nota Fiscal'
      TabOrder = 0
      object chkValProduto: TCheckBox
        Left = 9
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Vr. Produtos'
        TabOrder = 0
      end
      object chkValFre: TCheckBox
        Left = 9
        Top = 32
        Width = 97
        Height = 17
        Caption = 'Frete'
        TabOrder = 1
      end
      object chkIcms: TCheckBox
        Left = 112
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Valor ICMS'
        TabOrder = 3
      end
      object chkSeguro: TCheckBox
        Left = 9
        Top = 48
        Width = 97
        Height = 17
        Caption = 'Seguro'
        TabOrder = 2
      end
      object chkPis: TCheckBox
        Left = 112
        Top = 32
        Width = 97
        Height = 17
        Caption = 'PIS'
        TabOrder = 4
      end
      object chkCofins: TCheckBox
        Left = 112
        Top = 48
        Width = 97
        Height = 17
        Caption = 'COFINS'
        TabOrder = 5
      end
      object chkIpi: TCheckBox
        Left = 215
        Top = 16
        Width = 97
        Height = 17
        Caption = 'IPI'
        TabOrder = 6
      end
      object chkII: TCheckBox
        Left = 215
        Top = 48
        Width = 144
        Height = 17
        Caption = 'Imposto de Importa'#231#227'o(II)'
        TabOrder = 8
      end
      object chkAfrmm: TCheckBox
        Left = 376
        Top = 32
        Width = 97
        Height = 17
        Caption = 'AFRMM'
        TabOrder = 10
      end
      object chkSiscomex: TCheckBox
        Left = 376
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Siscomex'
        TabOrder = 9
      end
      object chkDesAdu: TCheckBox
        Left = 376
        Top = 48
        Width = 160
        Height = 17
        Caption = 'Despesas Aduaneiras'
        TabOrder = 11
      end
      object chkIOF: TCheckBox
        Left = 215
        Top = 32
        Width = 97
        Height = 17
        Caption = 'IOF'
        TabOrder = 7
      end
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 723
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 1
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 103
      Top = 1
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCODPER: TDBEditFocus
      Tag = 99
      Left = 9
      Top = 14
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ADU_CODPER'
      DataSource = dtsDados
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDESPER: TDBEditFocus
      Tag = 99
      Left = 103
      Top = 14
      Width = 440
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ADU_DESPER'
      DataSource = dtsDados
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object dtsDados: TDataSource
    Left = 416
    Top = 176
  end
end
