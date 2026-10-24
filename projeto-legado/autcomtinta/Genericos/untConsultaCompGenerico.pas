unit untConsultaCompGenerico;

interface

uses
  untPnlBotoesAcoesNovaConsulta;

type
  TfrmConsultaCompGenerico = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

implementation

uses
  untAutcomTintaFactory;

procedure TfrmConsultaCompGenerico.pTarefaFormulacao(Sender: TObject);
begin
  TAutcomTintaFactory.GetIAutcomTinta(strIdePro).pTarefaFormulacao(Sender, Self);
end;

procedure TfrmConsultaCompGenerico.pTarefaPrecos(Sender: TObject);
begin
  TAutcomTintaFactory.GetIAutcomTinta(strIdePro).pTarefaPrecos(Sender, Self);
end;

procedure TfrmConsultaCompGenerico.pTarefaVenda(Sender: TObject);
begin
  TAutcomTintaFactory.GetIAutcomTinta(strIdePro).pTarefaVenda(Sender, Self);

end;

end.
