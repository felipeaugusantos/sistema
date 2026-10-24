inherited frmLibVendasEntrega: TfrmLibVendasEntrega
  Width = 1089
  Height = 640
  Caption = 'Libera'#231#227'o de pedidos para o Aplicativo'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 1089
  ExplicitHeight = 640
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 569
    Width = 1083
    Height = 26
    TabOrder = 1
    ExplicitTop = 569
    ExplicitWidth = 1083
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 1002
      Height = 22
      ExplicitTop = 3
      ExplicitWidth = 1079
      ExplicitHeight = 25
      object btnMarDes: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 196
        Height = 22
        Caption = '[ENTER] Marcar/Desmarcar Pedido'
        TabOrder = 0
        OnClick = btnMarDesClick
      end
      object btnMarTod: TBitBtnLocked
        Left = 196
        Top = 0
        Width = 161
        Height = 22
        Caption = '[F2] Marcar Todos Pedidos'
        TabOrder = 1
        OnClick = btnMarTodClick
      end
      object btnAtuali: TBitBtnLocked
        Left = 357
        Top = 0
        Width = 84
        Height = 22
        Caption = '[F5] Atualizar'
        TabOrder = 2
        OnClick = btnAtualiClick
      end
      object btnEnvPed: TBitBtnLocked
        Left = 441
        Top = 0
        Width = 184
        Height = 22
        Caption = '[F10] Liberar para Entrega'
        DoubleBuffered = False
        TabOrder = 3
        OnClick = btnEnvPedClick
      end
      object btnOutrasEntregas: TBitBtnLocked
        Left = 625
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F11] Outras Entregas'
        TabOrder = 4
        OnClick = btnOutrasEntregasClick
      end
      object btnItensDoPedido: TBitBtnLocked
        Left = 745
        Top = 0
        Width = 161
        Height = 22
        Caption = '[F12] Itens do Pedido'
        DoubleBuffered = False
        TabOrder = 5
        OnClick = btnItensDoPedidoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1004
      Top = 2
      Align = alRight
      ExplicitLeft = 1004
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 595
    Width = 1083
    TabOrder = 2
    ExplicitTop = 595
    ExplicitWidth = 1083
    inherited pnlNomeForm: TPanel
      Left = 912
      ExplicitLeft = 912
    end
    inherited pnlInfo: TPanel
      Width = 912
      ExplicitWidth = 912
    end
  end
  object btnEnviarMotVei: TBitBtnLocked [3]
    Left = 499
    Top = 279
    Width = 177
    Height = 28
    Caption = 'Enviar Motoristas e Ve'#237'culos'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000030000000B00000013000000190000001A0000
      00140000000B0000000300000000000000000000000000000000000000000000
      000000000000000000060402011C4827118B7C431ED2A65927FFA55927FF7E44
      1ED442230F7B0100000F0000000E000000070000000000000000000000000000
      000000000005120A05348A4F26DDC58A53FFDCB37CFFEFD298FFEFD198FFB676
      43FF2E1A0C62100904398F5127E10E05013A0000000600000000000000000000
      0002040201198D552BDCD1A169FFF1D6A5FFCE9E6EFFC08656FFBD8251FF613A
      1DA6000000227D4B26CBE2B97BFF5F290FCF0101001900000003000000000000
      00074C2F1B82C99765FFECD2A3FFB98154FB5238238A120C07300F0A06270201
      01194C2F1B88CE9D66FFF6DC9BFFBA8657FF3F1C0C910000000D000000000000
      000A8C5B36D0E3C598FFCB9D75FF573B258C0000000C00000003000000062014
      0C43BD875AFBF8E5BCFFF8DFA5FFF7E4BAFFA16540FC1C0E074C000000080000
      0014B37A4BFAF5E6BDFFBC8356FF0D0704300000000C00000003000000079666
      3FD5B87D4DFFBB8153FFF2D9A1FFB87D4DFFB87C4DFF9C6941DE845331D3A263
      3BFFBB8557FFF6E7BFFFBF8B5EFFA06238FF87522FDC00000006000000020000
      000B0D08042FA1653CFFF4DEAEFFB68155FA000000180000000A1F170F34C79D
      75FBFBF5DCFFFCF3CCFFFAF4DAFFB3855FFB21150C4100000004000000020000
      0009492C1886BA8B5EFFE7CEA7FF926B48CB0000000900000000000000045540
      2D77DDC1A2FFFDF7D9FFD4B598FF5037227F0202010C0D08041F110A05274B2D
      1986A1683EFAF3E4C3FFD8B692FF533F2C780000000400000000000000000000
      00058F6F50BCEFE1CDFF886343C20202010D58382091A3693CFFA66F43FFBE94
      6DFFF4E9D1FFE3CAADFFA47E5BD60504030E0000000100000000000000000000
      0001130F0B1DAB8863DA18130E242C1E1248B78B63FDF8F3E2FFF9F3E4FFEDDE
      C7FFDCC1A1FFA3815ED215110C22000000020000000000000000000000000000
      000000000001000000010101000342301E629A7B5CC2C6A078F9C6A078F9997B
      5DC3564634710504030A00000001000000000000000000000000000000000000
      0000000000000000000000000000000000010000000200000002000000020000
      0002000000010000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000}
    TabOrder = 3
    OnClick = btnEnviarMotVeiClick
  end
  object pnlLegendas: TPanel [4]
    Left = 0
    Top = 548
    Width = 1083
    Height = 21
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitTop = 539
    object lblDevRom: TLabel
      Left = 36
      Top = 4
      Width = 210
      Height = 14
      Caption = 'Documento emitido h'#225' menos de 30 minutos'
    end
    object Label4: TLabel
      Left = 278
      Top = 4
      Width = 225
      Height = 14
      Caption = 'Documento emitido entre 30 e 60 minutos atr'#225's'
    end
    object Label7: TLabel
      Left = 540
      Top = 4
      Width = 200
      Height = 14
      Caption = 'Documento emitido h'#225' mais de 60 minutos'
    end
    object shpLegenda1: TShape
      Left = 13
      Top = 3
      Width = 18
      Height = 15
      Brush.Color = 9498256
    end
    object shpLegenda2: TShape
      Left = 255
      Top = 3
      Width = 18
      Height = 15
      Brush.Color = 9234160
    end
    object shpLegenda3: TShape
      Left = 517
      Top = 3
      Width = 18
      Height = 15
      Brush.Color = 7504122
    end
  end
  object pgcExportacoes: TcxPageControl [5]
    Left = 0
    Top = 0
    Width = 1083
    Height = 548
    Align = alClient
    TabOrder = 5
    Properties.ActivePage = tbsExpPedidos
    Properties.CustomButtons.Buttons = <>
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    ExplicitHeight = 539
    ClientRectBottom = 544
    ClientRectLeft = 4
    ClientRectRight = 1079
    ClientRectTop = 25
    object tbsExpPedidos: TcxTabSheet
      Caption = 'Exporta'#231#227'o de Pedidos'
      ImageIndex = 0
      ExplicitHeight = 510
      object pnlDados: TPanel
        Left = 0
        Top = 0
        Width = 1075
        Height = 519
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        ExplicitHeight = 510
        object pnlGrid: TPanel
          Left = 1
          Top = 293
          Width = 1073
          Height = 225
          Align = alClient
          Caption = 'pnlGrid'
          TabOrder = 0
          ExplicitHeight = 216
          object cxgDados: TcxGridCitel
            Left = 1
            Top = 1
            Width = 1071
            Height = 223
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 214
            object cxgDadosTableView1: TcxGridDBTableViewCitel
              OnKeyDown = cxgDadosTableView1KeyDown
              Navigator.Buttons.CustomButtons = <>
              OnCustomDrawCell = cxgDadosTableView1CustomDrawCell
              OnFocusedRecordChanged = cxgDadosTableView1FocusedRecordChanged
              DataController.DataSource = dtsDados
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.ShowEditButtons = gsebForFocusedRecord
              OptionsView.GroupByBox = False
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object cxgDadosTableView1DTAEMI: TcxGridDBColumn
                Caption = 'Dt. Emiss'#227'o'
                DataBinding.FieldName = 'DTAEMI'
              end
              object cxgDadosTableView1DTAENT: TcxGridDBColumn
                Caption = 'Dt. Entrega'
                DataBinding.FieldName = 'DTAENT'
                MinWidth = 64
                Options.ShowEditButtons = isebNever
                Width = 87
              end
              object cxgDadosTableView1NUMDOC: TcxGridDBColumn
                Caption = 'Documento'
                DataBinding.FieldName = 'DOCUMENTO'
                MinWidth = 130
                Width = 130
              end
              object cxgDadosTableView1DOCFAT: TcxGridDBColumn
                Caption = 'Doc. Faturamento'
                DataBinding.FieldName = 'DOCFAT'
                Width = 141
              end
              object cxgDadosTableView1NOMCLI: TcxGridDBColumn
                Caption = 'Cliente'
                DataBinding.FieldName = 'NOMCLI'
                MinWidth = 150
                Width = 169
              end
              object cxgDadosTableView1CODVEN: TcxGridDBColumn
                Caption = 'Vendedor'
                DataBinding.FieldName = 'CODVEN'
                MinWidth = 35
                Width = 109
              end
              object cxgDadosTableView1VLRCON: TcxGridDBColumn
                Caption = 'Vr. Documento'
                DataBinding.FieldName = 'VLRCON'
                MinWidth = 82
                Width = 101
              end
              object cxgDadosTableView1NOMCID: TcxGridDBColumn
                Caption = 'Cidade'
                DataBinding.FieldName = 'CID_NOMCID'
                Width = 170
              end
              object cxgDadosTableView1STAENT: TcxGridDBColumn
                Caption = 'Status Entrega'
                DataBinding.FieldName = 'STAWMS'
                MinWidth = 150
                Width = 150
              end
              object cxgDadosTableView1MARDES: TcxGridDBColumn
                DataBinding.FieldName = 'MARDES'
                Visible = False
              end
              object cxgDadosTableView1SEMAFORO: TcxGridDBColumn
                DataBinding.FieldName = 'SEMAFORO'
                Visible = False
              end
            end
            object cxgDadosLevel1: TcxGridLevel
              GridView = cxgDadosTableView1
            end
          end
        end
        object pnlFiltros: TPanel
          Left = 1
          Top = 1
          Width = 1073
          Height = 292
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          DesignSize = (
            1073
            292)
          object Label5: TLabel
            Left = 9
            Top = 8
            Width = 51
            Height = 14
            Caption = 'Data Inicial'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 80
            Top = 8
            Width = 47
            Height = 14
            Caption = 'Data Final'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl1: TLabel
            Left = 9
            Top = 202
            Width = 47
            Height = 14
            Caption = 'Vendedor'
          end
          object Label2: TLabel
            Left = 401
            Top = 161
            Width = 32
            Height = 14
            Caption = 'Cliente'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblEmpresa: TLabel
            Left = 401
            Top = 201
            Width = 42
            Height = 14
            Caption = 'Empresa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label1: TLabel
            Left = 9
            Top = 161
            Width = 75
            Height = 14
            Caption = 'Transportadora'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblNroPedido: TLabel
            Left = 9
            Top = 51
            Width = 62
            Height = 14
            Caption = 'N'#186' do Pedido'
          end
          object mskDtaIni: TMaskEditFocus
            Tag = 99
            Left = 9
            Top = 22
            Width = 69
            Height = 22
            EditMask = '99/99/9999;1;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 0
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object mskDtaFin: TMaskEditFocus
            Tag = 99
            Left = 80
            Top = 22
            Width = 70
            Height = 22
            EditMask = '99/99/9999;1;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 1
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object edtCodVen: TEditFocus
            Tag = 99
            Left = 9
            Top = 216
            Width = 70
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 3
            TabOrder = 11
            OnKeyPress = edtCodVenKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttAlfanumerico
          end
          object edtNomVen: TEditFocus
            Left = 80
            Top = 216
            Width = 310
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ReadOnly = True
            TabOrder = 12
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object rdgCtrEnt: TRadioGroup
            Left = 6
            Top = 244
            Width = 384
            Height = 37
            Caption = 'Status do Pedido'
            Columns = 3
            ItemIndex = 0
            Items.Strings = (
              'Todos'
              'Aguardando envio'
              'Enviado para entrega')
            TabOrder = 15
          end
          object edtCodCli: TEditFocus
            Tag = 99
            Left = 401
            Top = 175
            Width = 69
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 8
            ParentFont = False
            TabOrder = 9
            OnKeyPress = edtCodCliKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttNumerico
          end
          object edtDesCliente: TEditFocus
            Left = 472
            Top = 175
            Width = 310
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = 16768952
            ReadOnly = True
            TabOrder = 10
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtCodEmp: TEditFocus
            Tag = 99
            Left = 401
            Top = 216
            Width = 69
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 13
            OnKeyPress = edtCodEmpKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttNumerico
          end
          object edtDesEmpresa: TEditFocus
            Left = 472
            Top = 216
            Width = 310
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ReadOnly = True
            TabOrder = 14
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object gpbDocumento: TGroupBox
            Left = 6
            Top = 92
            Width = 186
            Height = 59
            Caption = 'Documento'
            TabOrder = 4
            object Label10: TLabel
              Left = 8
              Top = 17
              Width = 54
              Height = 14
              Caption = 'Documento'
            end
            object Label11: TLabel
              Left = 91
              Top = 17
              Width = 38
              Height = 14
              Caption = 'Esp'#233'cie'
            end
            object Label12: TLabel
              Left = 134
              Top = 17
              Width = 42
              Height = 14
              Caption = 'Empresa'
            end
            object edtDocFat: TEditFocus
              Tag = 99
              Left = 7
              Top = 32
              Width = 81
              Height = 22
              Alignment = taLeftJustify
              MaxLength = 12
              TabOrder = 0
              OnExit = edtDocFatExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 12
              TipoTexto = ttInteiro
            end
            object edtEspFat: TEditFocus
              Tag = 99
              Left = 91
              Top = 32
              Width = 41
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 2
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 2
              TipoTexto = ttAlfanumerico
            end
            object edtEmpFat: TEditFocus
              Tag = 99
              Left = 134
              Top = 32
              Width = 45
              Height = 22
              Alignment = taLeftJustify
              MaxLength = 3
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 3
              TipoTexto = ttInteiro
            end
          end
          object edtCodTra: TEditFocus
            Tag = 99
            Left = 9
            Top = 175
            Width = 69
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 5
            ParentFont = False
            TabOrder = 7
            OnKeyPress = edtCodTraKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtNomTra: TEditFocus
            Left = 80
            Top = 175
            Width = 310
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = 16768952
            ReadOnly = True
            TabOrder = 8
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtNroPedido: TEditFocus
            Tag = 99
            Left = 9
            Top = 66
            Width = 141
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 12
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 12
            TipoTexto = ttInteiro
          end
          object btnFiltrar: TBitBtnLocked
            Left = 401
            Top = 253
            Width = 87
            Height = 28
            Caption = '&Consultar'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
              609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
              D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
              9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
              95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
              8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
              A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
              A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
              E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
              B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
              ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
              E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
              BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
              27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
              EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
              C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
              C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
              8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
              CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
              D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
              FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
              CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
              68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 16
            OnClick = btnFiltrarClick
          end
          object rdgClientes: TRadioGroup
            Left = 401
            Top = 55
            Width = 209
            Height = 100
            Caption = 'Envio de Clientes'
            ItemIndex = 0
            Items.Strings = (
              'Todos'
              'Ativos'
              'Inativos')
            TabOrder = 5
          end
          object btnEnvCli: TBitBtnLocked
            Left = 499
            Top = 122
            Width = 105
            Height = 28
            Caption = 'Enviar Clientes'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF102F22184A341E5C411E
              5B40184732FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF22674C23966D23B48124CA9239CF9D37886AFFFFFFFFFFFF2A7B5C1467
              44FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2E886728B5863BDAA859E0B76FE5C25F
              C6A61F533FFFFFFF1E523D27B7861EB07D0C3E28FFFFFFFFFFFFFFFFFF308062
              2BBA8B42DDAD65CEAD53AB8E3A8B6E2F7D60FFFFFFFFFFFF2F967128D59E28D5
              9E1D805AFFFFFFFFFFFFFFFFFF3CAC882DDAA55ECFAE45987CFFFFFFFFFFFFFF
              FFFFFFFFFF2B73572ACC9829D8A12AD7A026C592145438FFFFFF2A725838C79B
              30DDA95CB699194133FFFFFFFFFFFFFFFFFF19413260B89C83ECCF2BDAA534DB
              A888EDD0479D7FFFFFFF358C6D50DFB661E8C23F9475040A08FFFFFFFFFFFFFF
              FFFF36896C378F70419A7B30DCA838D7A7358A6B34886A317E613B997A98EDD8
              8DF1D8398E6D040B08FFFFFFFFFFFFFFFFFFFFFFFF0205043F967543E2B34DDA
              B11D6749FFFFFFFFFFFF34856A98E1CF9AF4DE57A98B113826FFFFFFFFFFFFFF
              FFFFFFFFFF12372859B0928BF1D76ECEB21E6047FFFFFFFFFFFFFFFFFF81CFBA
              B4F9EA82D3BC3A87670E3523030C08030C080E32223D8E6E84DFC7AAF6E56FB8
              A0164232FFFFFFFFFFFFFFFFFF55B295A5E5D5BCFAED94E5D056A3862D7B592D
              7B5954A38685D4BDB5F8EA9ADAC9419477FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              69C6AAAAE7D9CBFDF3C1FBEFBAF9ECB8F9EBBEFBEEC7FCF2A6E5D55CB096FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF53AB908AD7C2B2EADDCEF9F1CE
              F9F1B1EADC87D4BF50A78CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF3A907649B89649B795399075FFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            TabOrder = 6
            OnClick = btnEnvCliClick
          end
          object cxgOutrasEntregas: TcxGrid
            Left = 796
            Top = 7
            Width = 269
            Height = 279
            Anchors = [akTop, akRight, akBottom]
            TabOrder = 17
            Visible = False
            object cxgOutrasEntregasDBTableView1: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsOutrasEntregas
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              DataController.OnDataChanged = cxgOutrasEntregasDBTableView1DataControllerDataChanged
              OptionsData.Editing = False
              OptionsSelection.CellSelect = False
              OptionsView.GroupByBox = False
              object cxgOutrasEntregasDBTableView1Column1: TcxGridDBColumn
                Caption = 'Doc.'
                DataBinding.FieldName = 'NumeroEntrega'
                Width = 80
              end
              object cxgOutrasEntregasDBTableView1Column2: TcxGridDBColumn
                Caption = 'Descri'#231#227'o Entrega'
                DataBinding.FieldName = 'DescricaoEntrega'
                Width = 178
              end
            end
            object cxgOutrasEntregasLevel1: TcxGridLevel
              GridView = cxgOutrasEntregasDBTableView1
            end
          end
          object rdgFiltroData: TRadioGroup
            Left = 159
            Top = 8
            Width = 165
            Height = 36
            Caption = 'Filtrar por data de'
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'Emiss'#227'o'
              'Entrega')
            TabOrder = 2
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1016
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1016
    Top = 148
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1016
    Top = 208
  end
  object dtsDados: TDataSource
    Left = 20
    Top = 408
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 1016
    Top = 264
  end
  object cdsOutrasEntregas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 881
    Top = 226
    object cdsOutrasEntregasNumeroEntrega: TStringField
      DisplayWidth = 30
      FieldName = 'NumeroEntrega'
    end
    object cdsOutrasEntregasDescricaoEntrega: TStringField
      DisplayWidth = 80
      FieldName = 'DescricaoEntrega'
    end
  end
  object dtsOutrasEntregas: TDataSource
    DataSet = cdsOutrasEntregas
    Left = 881
    Top = 178
  end
end
