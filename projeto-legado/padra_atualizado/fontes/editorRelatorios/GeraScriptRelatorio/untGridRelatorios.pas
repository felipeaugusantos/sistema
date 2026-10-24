unit untGridRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, TConverte, StrUtils,
  System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmGridRelatorios = class(TForm)
    pgcRelat: TPageControl;
    tbsGrid: TTabSheet;
    tbsScript: TTabSheet;
    Panel1: TPanel;
    cxvRelat: TcxGridDBTableView;
    cxRelatLevel1: TcxGridLevel;
    cxRelat: TcxGrid;
    cxvRelatCODREL: TcxGridDBColumn;
    cxvRelatColumn2: TcxGridDBColumn;
    cxvRelatColumn3: TcxGridDBColumn;
    cxvRelatColumn4: TcxGridDBColumn;
    mmoScript: TMemo;
    btnSair: TBitBtnLocked;
    dtsConsulta: TDataSource;
    cxvRelatColumn1: TcxGridDBColumn;
    Splitter1: TSplitter;
    dtsCadTem: TDataSource;
    cxvRelatColumn5: TcxGridDBColumn;
    cxvRelatColumn6: TcxGridDBColumn;
    pnlBotoes: TPanel;
    Label1: TLabel;
    cxvRelatColumn7: TcxGridDBColumn;
    cxvRelatColumn8: TcxGridDBColumn;
    cxvRelatColumn9: TcxGridDBColumn;
    chkModoExporta: TCheckBox;
    cmbExporta: TComboBox;
    btnGerar: TBitBtnLocked;
    btnAtualizar: TBitBtnLocked;
    chkRelPadrao: TCheckBox;
    ckbSalvarCADVAL: TCheckBox;
    Panel2: TPanel;
    cxgCadItem: TcxGrid;
    cxvCadTem: TcxGridDBTableView;
    cxvCadTemCODIGO: TcxGridDBColumn;
    cxvCadTemDESCRI: TcxGridDBColumn;
    cxgCadItemLevel1: TcxGridLevel;
    Splitter2: TSplitter;
    cxgCadMod: TcxGrid;
    cxvCadMod: TcxGridDBTableView;
    cxvCadModCODIGO: TcxGridDBColumn;
    cxvCadModDESCRICAO: TcxGridDBColumn;
    cxGridCadModLevel1: TcxGridLevel;
    dtsCadMod: TDataSource;
    cxvCadTemDesgru: TcxGridDBColumn;
    cxvRelatColumn10: TcxGridDBColumn;
    procedure cxvRelatCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvRelatKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvCadTemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxvCadTemCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure chkModoExportaClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure cxvCadModCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvCadModKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    objConverte: TConvert;
    strRelEsp : String;
    strCodcli : String;
  end;

var
  frmGridRelatorios: TfrmGridRelatorios;

implementation

{$R *.dfm}

{$WARN SYMBOL_PLATFORM OFF}
procedure TfrmGridRelatorios.btnAtualizarClick(Sender: TObject);
begin
  objConverte.cdsCadRel.Refresh;
  objConverte.cdsCadTem.Refresh;
end;

procedure TfrmGridRelatorios.btnGerarClick(Sender: TObject);
var
  strChave_, strCodRel, strCodMod, strDescri, strArquiv, strVerRel, strRelRel, strCodDir: string;
  strPastaDestino, strCodigos, strChaves: string;
  intIndex, intRecNo, intRecNoScript: Integer;
  blnPrimeiroArquivo, blnSalvaCADVAL, blnInicioScript: Boolean;
  dlgAbrePasta: TFileOpenDialog;

  procedure pEscreveArquivo(strPastaDestino, strVerRel, strRelRel, strArquiv: string; var strCodigos: string; blnSalvaCADVAL: Boolean);
  var
    strCaminhoCompleto: string;
  begin
    with objConverte do
    begin

      if objConverte.stlListaCadTem.Count > 0 then
      begin
        mmoScript.Lines.Add('Gerando templates...');
        Application.ProcessMessages;
        pGeraTemplates;
      end;

      if cmbExporta.ItemIndex <> 2 then
      begin
        if not DirectoryExists(strPastaDestino + '\' + strVerRel + IfThen(cmbExporta.ItemIndex = 0, '\' + strRelRel, '')) then
        begin
          ForceDirectories(strPastaDestino + '\' + strVerRel + IfThen(cmbExporta.ItemIndex = 0, '\' + strRelRel, ''));
        end;
      end;

      pAlimentaFimScript(False, blnSalvaCADVAL, False);

      mmoScript.Lines.Add('Escrevendo arquivo ' + strArquiv + '...');
      Application.ProcessMessages;
      strCaminhoCompleto := strPastaDestino + '\' + IfThen(cmbExporta.ItemIndex = 2, '', strVerRel) + IfThen(cmbExporta.ItemIndex = 0, '\' + strRelRel, '') + '\' + strArquiv;
      stlScript.SaveToFile(strCaminhoCompleto, TEncoding.UTF8);

      mmoScript.Lines.Add('Arquivo ' + strArquiv + ' gerado com sucesso!');
      Application.ProcessMessages;

      mmoScript.Lines.Add('');
      strCodigos := '';
    end;
  end;
begin
  mmoScript.Clear;

  strChaves := '';
  strCodDir := '';
  blnSalvaCADVAL := ckbSalvarCADVAL.Checked;

  blnInicioScript := True;

  objConverte.pTemRelOutraVersao;

  if ((objConverte.stlLista.Count = 0) and (objConverte.stlListaCadTem.Count = 0) and (objConverte.stlListaCadMod.Count = 0)) then
    ShowMessage('Selecione um registro');

  if (objConverte.stlLista.Count > 0) then
    if objConverte.fTemCadDir(strChaves) then
      if not(MessageDlg('Atenção! Direito(s) de acesso encontrado(s) entre os filtros dos relatórios selecionados. ' +
                        'Certifique-se de que tenha reservado a(s) chave(s) antes de prosseguir.' + Chr(13) + Chr(10) + Chr(13) + Chr(10) +
                        strChaves + Chr(13) + Chr(10) + Chr(13) + Chr(10) +
                        'Deseja continuar?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
        Exit;

  if not chkModoExporta.Checked then
  begin
    if ((objConverte.stlLista.Count > 0) or (objConverte.stlListaCadTem.Count > 0) or (objConverte.stlListaCadMod.Count > 0)) then
    begin
      if objConverte.fGeraScript(strCodDir, True, True, blnSalvaCADVAL, blnInicioScript, '', False) then
      begin
        mmoScript.Text := objConverte.stlScript.Text;
        pgcRelat.ActivePage := tbsScript;
      end;
    end;
  end
  else
  begin
    with objConverte do
    begin
      if stlLista.Count > 0 then
      begin
        dlgAbrePasta := TFileOpenDialog.Create(nil);
        dlgAbrePasta.Options := [fdoPickFolders];
        try
          if (objConverte.strCaminhoArquiv <> '') and (DirectoryExists(objConverte.strCaminhoArquiv)) then
          begin
            strPastaDestino := objConverte.strCaminhoArquiv;
          end
          else if (dlgAbrePasta.Execute) then
          begin
            strPastaDestino := (dlgAbrePasta.FileName);
          end;

          if strPastaDestino <> '' then
          begin
            pgcRelat.ActivePage := tbsScript;
            intRecNo := cdsCadRel.RecNo;
            cdsCadRel.DisableControls;
            cdsCadRel.IndexFieldNames := 'ARQUIV;VERREL;RELREL;CODREL';
            cdsCadRel.First;
            try

              strCodigos := '';
              blnPrimeiroArquivo := True;

              mmoScript.Lines.Add('Iniciando exportação de scripts...');
              mmoScript.Lines.Add('');
              Application.ProcessMessages;

              while not cdsCadRel.Eof do
              begin

                if cdsCadRel.FieldByName('ARQUIV').AsString <> '' then
                begin

                  strChave_ := cdsCadRel.FieldByName('CHAVE_').AsString;
                  strCodRel := cdsCadRel.FieldByName('CODREL').AsString;
                  strDescri := cdsCadRel.FieldByName('DESCRI').AsString;
                  strCodMod := cdsCadRel.FieldByName('CODMOD').AsString;

                  if stlLista.Find(strCodRel, intIndex) then
                  begin

                    if blnPrimeiroArquivo then
                    begin
                      pGeraCabecalho;
                      blnInicioScript := True;
                      blnPrimeiroArquivo := False;
                      strArquiv := cdsCadRel.FieldByName('ARQUIV').AsString;
                      strVerRel := cdsCadRel.FieldByName('VERREL').AsString;
                      strRelRel := cdsCadRel.FieldByName('RELREL').AsString;
                    end;

                    if strArquiv <> cdsCadRel.FieldByName('ARQUIV').AsString then
                    begin
                      blnInicioScript := True;
                      pEscreveArquivo(strPastaDestino, strVerRel, strRelRel, strArquiv, strCodigos, blnSalvaCADVAL);
                      strCodDir := '';
                      pGeraCabecalho;
                      strArquiv := cdsCadRel.FieldByName('ARQUIV').AsString;
                      strVerRel := cdsCadRel.FieldByName('VERREL').AsString;
                      strRelRel := cdsCadRel.FieldByName('RELREL').AsString;
                    end;

                    if stlLista.Find(strCodRel, intIndex) then
                    begin
                      strCodigos := strCodigos + IfThen(strCodigos = '', '', ',') + strCodRel;
                      mmoScript.Lines.Add('Gerando relatório ' + strChave_ + ' - ' + strDescri + '...');
                      Application.ProcessMessages;
                      intRecNoScript := cdsCadRel.RecNo;
                      fGeraScript(strCodDir, False, False, blnSalvaCADVAL, blnInicioScript, strCodRel, True);
                      cdsCadRel.RecNo := intRecNoScript;
                    end;

                  end;

                end;

                cdsCadRel.Next;
              end;

              if not blnPrimeiroArquivo then
              begin
                pEscreveArquivo(strPastaDestino, strVerRel, strRelRel, strArquiv, strCodigos, blnSalvaCADVAL);
                mmoScript.Lines.Add('Processo de exportação de scripts concluído!');
              end
              else
                mmoScript.Lines.Add('Nenhum relatório foi exportado pois o campo Arquivo dos registros selecionados está vazio!');

              Application.ProcessMessages;

            finally
              cdsCadRel.IndexFieldNames := '';
              cdsCadRel.RecNo := intRecNo;
              cdsCadRel.EnableControls;
            end;
          end;

        finally
          FreeAndNil(dlgAbrePasta);
        end;
      end;
    end;

  end;
end;
{$WARN SYMBOL_PLATFORM ON}

procedure TfrmGridRelatorios.chkModoExportaClick(Sender: TObject);
begin
  cmbExporta.Enabled := chkModoExporta.Checked;

  objConverte.blnRelPadrao := chkRelPadrao.Checked;
end;

procedure TfrmGridRelatorios.cxvCadModCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  If objConverte.fInListaCadMod(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxvCadModCODIGO.Index])) Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;
  End;

end;

procedure TfrmGridRelatorios.cxvCadModKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

    If Key = VK_RETURN Then
  Begin
    objConverte.pAddListaModelos;
    cxvCadModCODIGO.Width := cxvCadModCODIGO.Width + 1;
    cxvCadModCODIGO.Width := cxvCadModCODIGO.Width - 1;
  End;

  if Key = VK_F6 then
    objConverte.pAddMarcaDesmarcaTodosListaModelo(True);

  if Key = VK_F7 then
    objConverte.pAddMarcaDesmarcaTodosListaModelo(False);

end;

procedure TfrmGridRelatorios.cxvCadTemCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  If objConverte.fInListaCadTem(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxvCadTemCODIGO.Index])) Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;
  End;

end;

procedure TfrmGridRelatorios.cxvCadTemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If Key = VK_RETURN Then
  Begin
    objConverte.pAddListaTemplate;
    cxvCadTemCODIGO.Width := cxvCadTemCODIGO.Width + 1;
    cxvCadTemCODIGO.Width := cxvCadTemCODIGO.Width - 1;
  End;

  if Key = VK_F6 then
    objConverte.pAddMarcaDesmarcaTodosListaTemplate(True);

  if Key = VK_F7 then
    objConverte.pAddMarcaDesmarcaTodosListaTemplate(False);

end;

procedure TfrmGridRelatorios.cxvRelatCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  If objConverte.fInLista(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxvRelatCODREL.Index])) Then
  Begin
    ACanvas.Brush.Color := clMoneyGreen;
  End;

end;

procedure TfrmGridRelatorios.cxvRelatKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If Key = VK_RETURN Then
  Begin
    objConverte.pAddLista;
    cxvRelatCODREL.Width := cxvRelatCODREL.Width + 1;
    cxvRelatCODREL.Width := cxvRelatCODREL.Width - 1;

    cxvCadTemCODIGO.Width := cxvCadTemCODIGO.Width + 1;
    cxvCadTemCODIGO.Width := cxvCadTemCODIGO.Width - 1;

    ckbSalvarCADVAL.Checked := objConverte.fRetornaSalvaCadVal();
  End;

  if Key = VK_F6 then
    objConverte.pAddMarcaDesmarcaTodosLista(True);

  if Key = VK_F7 then
  Begin
    objConverte.pAddMarcaDesmarcaTodosLista(False);

    cxvCadTemCODIGO.Width := cxvCadTemCODIGO.Width + 1;
    cxvCadTemCODIGO.Width := cxvCadTemCODIGO.Width - 1;
  End;

end;

procedure TfrmGridRelatorios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  Application.Terminate;
end;

procedure TfrmGridRelatorios.FormShow(Sender: TObject);
begin
  pgcRelat.ActivePage := tbsGrid;

  objConverte.blnRelPadrao := chkRelPadrao.Checked;
end;

end.
