inherited frmAlterarPrazoGarantia: TfrmAlterarPrazoGarantia
  Width = 802
  Height = 508
  Caption = 'Alterar Prazo Garantia Item Vendido'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 802
  ExplicitHeight = 508
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 435
    Width = 796
    ExplicitTop = 435
    ExplicitWidth = 796
    inherited FlwBotoes: TFlowPanel
      Width = 792
      ExplicitWidth = 792
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 100
        Height = 25
        Caption = '[F10] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 713
      ExplicitLeft = 713
    end
  end
  inherited pnlStatus: TPanel
    Top = 463
    Width = 796
    ExplicitTop = 463
    ExplicitWidth = 796
    inherited pnlNomeForm: TPanel
      Left = 625
      ExplicitLeft = 625
    end
    inherited pnlInfo: TPanel
      Width = 625
      ExplicitWidth = 625
    end
  end
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 796
    Height = 435
    Align = alClient
    Caption = 'pnlPrincipal'
    ShowCaption = False
    TabOrder = 2
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 794
      Height = 64
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlCabecalho'
      ShowCaption = False
      TabOrder = 0
      object pnlPesq: TPanel
        Left = 0
        Top = 0
        Width = 794
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlPesq'
        ShowCaption = False
        TabOrder = 0
        object lblCodEmp: TLabel
          Left = 693
          Top = 10
          Width = 45
          Height = 14
          Caption = 'Empresa:'
        end
        object lblNumDoc: TLabel
          Left = 8
          Top = 10
          Width = 57
          Height = 14
          Caption = 'Documento:'
        end
        object lblEspDoc: TLabel
          Left = 162
          Top = 10
          Width = 41
          Height = 14
          Caption = 'Esp'#233'cie:'
        end
        object lblCliente: TLabel
          Left = 238
          Top = 12
          Width = 35
          Height = 14
          Caption = 'Cliente:'
        end
        object edtCodCli: TEditFocus
          Tag = 99
          Left = 277
          Top = 8
          Width = 90
          Height = 22
          Alignment = taLeftJustify
          NumbersOnly = True
          TabOrder = 2
          OnKeyPress = edtCodCliKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttAlfanumerico
        end
        object edtEspDoc: TEditFocus
          Tag = 99
          Left = 207
          Top = 7
          Width = 26
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNumDoc: TEditFocus
          Tag = 99
          Left = 69
          Top = 7
          Width = 90
          Height = 22
          Alignment = taLeftJustify
          NumbersOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 12
          TipoTexto = ttAlfanumerico
        end
        object edtCodEmp: TEditFocus
          Tag = 99
          Left = 743
          Top = 7
          Width = 30
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = 16768952
          RequeridoColor = 16768952
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomCli: TEditFocus
          Tag = 99
          Left = 374
          Top = 7
          Width = 317
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = 16768952
          RequeridoColor = 16768952
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlDadosDoc: TPanel
        Left = 0
        Top = 33
        Width = 794
        Height = 31
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlDadosDoc'
        ShowCaption = False
        TabOrder = 1
        object lblCodVen: TLabel
          Left = 18
          Top = 5
          Width = 50
          Height = 14
          Caption = 'Vendedor:'
        end
        object lblDtaEmi: TLabel
          Left = 424
          Top = 7
          Width = 43
          Height = 14
          Caption = 'Emiss'#227'o:'
        end
        object lblVlrCon: TLabel
          Left = 568
          Top = 7
          Width = 69
          Height = 14
          Caption = 'Valor Cont'#225'bil:'
        end
        object edtCodVen: TEditFocus
          Left = 70
          Top = 3
          Width = 30
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = 16768952
          RequeridoColor = 16768952
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomVen: TEditFocus
          Tag = 99
          Left = 102
          Top = 3
          Width = 317
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = 16768952
          RequeridoColor = 16768952
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object medtDtaEmi: TMaskEditFocus
          Left = 470
          Top = 3
          Width = 89
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          EditMask = '!99/99/9999;1;_'
          MaxLength = 10
          ReadOnly = True
          TabOrder = 2
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = 16768952
          RequeridoColor = 16768952
          Requerido = False
          ValidaData = False
        end
        object edtVlrCon: TEditFocus
          Tag = 99
          Left = 640
          Top = 3
          Width = 121
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = 16768952
          RequeridoColor = 16768952
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 65
      Width = 794
      Height = 369
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel2'
      ShowCaption = False
      TabOrder = 1
      object cxgDados: TcxGrid
        Left = 0
        Top = 0
        Width = 794
        Height = 369
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgDadosDBTableView1: TcxGridDBTableView
          OnKeyDown = cxgDadosDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgDadosDBTableView1CustomDrawCell
          DataController.DataSource = dtsDados
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object cxgDadosDBTableView1SELECIONADO: TcxGridDBColumn
            Caption = 'Selecionado'
            DataBinding.FieldName = 'SELECIONADO'
            Visible = False
            Options.Editing = False
          end
          object cxgDadosDBTableView1CODITE: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'DET_CODITE'
            Options.Editing = False
            Width = 78
          end
          object cxgDadosDBTableView1DESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DET_DESCRI'
            Options.Editing = False
            Width = 210
          end
          object cxgDadosDBTableView1UNIDAD: TcxGridDBColumn
            Caption = 'Sigla'
            DataBinding.FieldName = 'DET_UNIDAD'
            Options.Editing = False
            Width = 68
          end
          object cxgDadosDBTableView1DET_QTDITE: TcxGridDBColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'DET_QTDITE'
            Options.Editing = False
          end
          object cxgDadosDBTableView1UNITAR: TcxGridDBColumn
            Caption = 'Vr. Unit'#225'rio'
            DataBinding.FieldName = 'DET_UNITAR'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
          end
          object cxgDadosDBTableView1TOTITE: TcxGridDBColumn
            Caption = 'Vr. Total'
            DataBinding.FieldName = 'DET_TOTITE'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
          end
          object cxgDadosDBTableView1TMPGAR: TcxGridDBColumn
            Caption = 'Prz Garantia (Meses)'
            DataBinding.FieldName = 'DET_TMPGAR'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ValidationOptions = []
            Properties.OnValidate = cxgDadosDBTableView1TMPGARPropertiesValidate
            OnCustomDrawCell = cxgDadosDBTableView1TMPGARCustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 150
          end
          object cxgDadosDBTableView1TMPGARORI: TcxGridDBColumn
            DataBinding.FieldName = 'TMPGARORI'
            Visible = False
            Options.Editing = False
          end
        end
        object cxgDadosLevel1: TcxGridLevel
          GridView = cxgDadosDBTableView1
        end
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
    Top = 48
  end
  object dtsDados: TDataSource
    Left = 593
    Top = 177
  end
end
